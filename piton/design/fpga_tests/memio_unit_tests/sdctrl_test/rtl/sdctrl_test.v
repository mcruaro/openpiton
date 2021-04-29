// Copyright (c) 2015 Princeton University
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Princeton University nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

`include "define.tmp.h"

// Filename: sdctrl_test.v
// Author: mmckeown
// Description: This module implements multiple tests for
//              the chipset sd card controller. The switch
//              inputs control the addressing mode and
//              test mode as below.
//
//              sw[2:0] - Addressing mode
//                  3'b000 - 0 Byte
//                  3'b001 - 1 Bytes
//                  3'b010 - 2 Bytes
//                  3'b011 - 4 Bytes
//                  3'b100 - 8 Bytes
//                  3'b101 - 16 Bytes (NOT SUPPORTED BY SD CONTROLLER)
//                  3'b110 - 32 Bytes (NOT SUPPORTED BY SD CONTROLLER)
//                  3'b111 - 64 Bytes (NOT SUPPORTED BY SD CONTROLLER)
//              sw[7:3] - Test mode
//                  5'd0 - Sequential walking ones test
//                  5'd1 - Sequential address own test
//                  5'd2 - Sequential random test
//                  5'd3 - Parallel address own test
//                  5'd4 - Parallel random data test (sequential address)
//                  5'd5-5'd31 - Reserved
//
//              The output LEDs can be read as below.
//
//              led[0] - clock locked
//              led[1] - logic reset (active low)
//              led[2] - logic reset and not DRAM calibration complete (active low)
//              led[3] - test running
//              led[4] - test done
//              led[5] - test timeout
//              led[7:6] - test passed 

module sdctrl_test(
`ifndef PITON_SDCTRL_TEST_SIM_CLKS
`ifdef PITON_CHIPSET_DIFF_CLK
    input                                       clk_osc_p,
    input                                       clk_osc_n,
`else // ifndef PITON_CHIPSET_DIFF_CLK
    input                                       clk_osc,
`endif // endif PITON_CHIPSET_DIFF_CLK
`else // ifdef PITON_SDCTRL_TEST_SIM_CLKS
    input                                       test_sys_clk,
    input                                       spi_sys_clk,
`endif // PITON_SDCTRL_TEST_SIM_CLKS

    input                                       rst_n,

    input  [7:0]                                sw,

    output [7:0]                                led,

    // SD interface
    input                                       spi_data_in,
    output                                      spi_data_out,
    output                                      spi_clk_out,
    output                                      spi_cs_n
);

///////////////////////
// Type declarations //
///////////////////////

`ifdef PITON_SDCTRL_TEST_MINI_TEST
parameter                                       SD_TOP_ADDR_BYTE = 10'h3ff;
parameter                                       SD_ADDR_SIZE = 10;
`else
parameter                                       SD_TOP_ADDR_BYTE = 31'h77afffff;
parameter                                       SD_ADDR_SIZE = 31;
`endif

// SW values
localparam                                      ADDRESSING_MODE_BITS_HI = 2;
localparam                                      ADDRESSING_MODE_BITS_LO = 0;

localparam                                      TEST_MODE_BITS_HI = 7;
localparam                                      TEST_MODE_BITS_LO = 3;

localparam                                      TEST_SEQ_WALKING_ONES = 5'd0;
localparam                                      TEST_SEQ_ADDRESS_OWN = 5'd1;
localparam                                      TEST_SEQ_RANDOM = 5'd2;
localparam                                      TEST_PAR_ADDRESS_OWN = 5'd3;
localparam                                      TEST_PAR_RANDOM_DATA = 5'd4;

// Decoded address increment value and data payload num flits
reg  [`PHY_ADDR_WIDTH-1:0]                      addr_incr_val;
reg  [7:0]                                      data_payload_flits;
reg  [`PHY_ADDR_WIDTH-1:0]                      mem_top_addr;

// Decoded test mode one-hot enable bits
reg  [4:0]                                      test_mode_en;
reg                                             test_seq_en;
reg                                             test_par_en;

wire                                            clk_locked;

`ifndef PITON_SDCTRL_TEST_SIM_CLKS
// Clocks
wire                                            test_sys_clk;
wire                                            spi_sys_clk;
`endif // PITON_SDCTRL_TEST_SIM_CLKS

// Resets
reg                                             rst_n_rect;
reg                                             rst_n_combined;
reg                                             rst_n_combined_f;
reg                                             rst_n_combined_ff;
reg                                             test_sys_rst_n;

// SD controller interface
reg                                             test_sd_val;
reg  [`NOC_DATA_WIDTH-1:0]                      test_sd_data;
wire                                            test_sd_rdy;

wire                                            sd_test_val;
wire [`NOC_DATA_WIDTH-1:0]                      sd_test_data;
reg                                             sd_test_rdy;

// Individual test driver memory controller interfaces
wire                                            seq_test_sd_val;
wire [`NOC_DATA_WIDTH-1:0]                      seq_test_sd_data;
wire                                            seq_sd_test_rdy;

wire                                            par_test_sd_val;
wire [`NOC_DATA_WIDTH-1:0]                      par_test_sd_data;
wire                                            par_sd_test_rdy;

// Individual test driver done and passed signals
wire                                            seq_test_running;
wire                                            seq_test_done;
wire                                            seq_test_timeout;
wire                                            seq_test_passed;

wire                                            par_test_running;
wire                                            par_test_done;
wire                                            par_test_timeout;
wire                                            par_test_passed;

// Aggregate test done and passed
reg                                             test_running;
reg                                             test_done;
reg                                             test_timeout;
reg                                             test_passed;

// SPI master Wishbone interface
wire                                            wb_ack;
wire [7:0]                                      wb_dat_i;
wire [7:0]                                      wb_adr;
wire [7:0]                                      wb_dat_o;
wire                                            wb_stb;
wire                                            wb_we;

// AXI-Lite bridge interface
wire [`NOC_DATA_WIDTH-1:0]                      converter_sd_aw_addr;
wire                                            converter_sd_aw_valid;
wire                                            converter_sd_aw_ready;
wire [`NOC_DATA_WIDTH-1:0]                      converter_sd_w_data;
wire [`NOC_DATA_WIDTH/8-1:0]                    converter_sd_w_strb;
wire                                            converter_sd_w_valid;
wire                                            converter_sd_w_ready;
wire [`NOC_DATA_WIDTH-1:0]                      converter_sd_ar_addr;
wire                                            converter_sd_ar_valid;
wire                                            converter_sd_ar_ready;
wire [`NOC_DATA_WIDTH-1:0]                      sd_converter_r_data;
wire [1:0]                                      sd_converter_r_resp;
wire                                            sd_converter_r_valid;
wire                                            sd_converter_r_ready;
wire [1:0]                                      sd_converter_b_resp;
wire                                            sd_converter_b_valid;
wire                                            sd_converter_b_ready;

//////////////////////
// Sequential Logic //
//////////////////////

// Synchronize resets
always @ (posedge test_sys_clk)
begin
    rst_n_combined_f <= rst_n_combined;
    rst_n_combined_ff <= rst_n_combined_f;
end

/////////////////////////
// Combinational Logic //
/////////////////////////

// Decode address increment value and data playload flits based on addressing mode
always @ *
begin
    case (sw[ADDRESSING_MODE_BITS_HI:ADDRESSING_MODE_BITS_LO])
        3'd0:
        begin
            addr_incr_val = {`PHY_ADDR_WIDTH{1'b0}};
            data_payload_flits = 8'd1;
            mem_top_addr = {`PHY_ADDR_WIDTH{1'b0}};
        end
        3'd1:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd1};
            data_payload_flits = 8'd1;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE};
        end
        3'd2:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd2};
            data_payload_flits = 8'd1;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE[SD_ADDR_SIZE-1:1], 1'd0};
        end
        3'd3:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd4};
            data_payload_flits = 8'd1;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE[SD_ADDR_SIZE-1:2], 2'd0};
        end
        3'd4:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd8};
            data_payload_flits = 8'd1;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE[SD_ADDR_SIZE-1:3], 3'd0};
        end
        3'd5:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd16};
            data_payload_flits = 8'd2;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE[SD_ADDR_SIZE-1:4], 4'd0};
        end
        3'd6:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd32};
            data_payload_flits = 8'd4;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE[SD_ADDR_SIZE-1:5], 5'd0};
        end
        3'd7:
        begin
            addr_incr_val = {{`PHY_ADDR_WIDTH-7{1'b0}}, 7'd64};
            data_payload_flits = 8'd8;
            mem_top_addr = {{`PHY_ADDR_WIDTH-SD_ADDR_SIZE{1'b0}}, SD_TOP_ADDR_BYTE[SD_ADDR_SIZE-1:6], 6'd0};
        end
        default:
        begin
            addr_incr_val = {`PHY_ADDR_WIDTH{1'bx}};
            data_payload_flits = 8'dx;
            mem_top_addr = {`PHY_ADDR_WIDTH{1'bx}};
        end
    endcase
end

// Decode test mode into one-hot enable bits
always @ *
begin
    case (sw[TEST_MODE_BITS_HI:TEST_MODE_BITS_LO])
        TEST_SEQ_WALKING_ONES:
        begin
            test_mode_en = 5'd1;
            test_seq_en = 1'b1;
            test_par_en = 1'b0;
        end
        TEST_SEQ_ADDRESS_OWN:
        begin
            test_mode_en = 5'd2;
            test_seq_en = 1'b1;
            test_par_en = 1'b0;
        end
        TEST_SEQ_RANDOM:
        begin
            test_mode_en = 5'd4;
            test_seq_en = 1'b1;
            test_par_en = 1'b0;
        end
        TEST_PAR_ADDRESS_OWN:
        begin
            test_mode_en = 5'd8;
            test_seq_en = 1'b0;
            test_par_en = 1'b1;
        end
        TEST_PAR_RANDOM_DATA:
        begin
            test_mode_en = 5'd16;
            test_seq_en = 1'b0;
            test_par_en = 1'b1;
        end
        default:
        begin
            test_mode_en = 4'd0;
            test_seq_en = 1'b0;
            test_par_en = 1'b0;
        end
    endcase
end

// Multiplex sd controller and test passed bits
always @ *
begin
    if (test_seq_en)
    begin
        test_sd_val = seq_test_sd_val;
        test_sd_data = seq_test_sd_data;
        sd_test_rdy = seq_sd_test_rdy;
        test_running = seq_test_running;
        test_done = seq_test_done;
        test_timeout = seq_test_timeout;
        test_passed = seq_test_passed;
    end
    else if (test_par_en)
    begin
        test_sd_val = par_test_sd_val;
        test_sd_data = par_test_sd_data;
        sd_test_rdy = par_sd_test_rdy;
        test_running = par_test_running;
        test_done = par_test_done;
        test_timeout = par_test_timeout;
        test_passed = par_test_passed;
    end
    else
    begin
        test_sd_val = 1'b0;
        test_sd_data = {`NOC_DATA_WIDTH{1'b0}};
        sd_test_rdy = 1'b0;
        test_running = 1'b0;
        test_done = 1'b1;
        test_timeout = 1'b0;
        test_passed = 1'b0;
    end
end

// Correct reset sense if needed
always @ *
begin
`ifdef PITON_FPGA_RST_ACT_HIGH
    rst_n_rect = ~rst_n;
`else // ifndef PITON_FPGA_RST_ACT_HIGH
    rst_n_rect = rst_n;
`endif // endif PITON_FPGA_RST_ACT_HIGH
end

// Create combined resets
always @ *
begin
    rst_n_combined = rst_n_rect & clk_locked;
    test_sys_rst_n = rst_n_combined_ff;
end

`ifdef PITON_SDCTRL_TEST_SIM_CLKS
assign clk_locked = 1'b1;
`endif // PITON_SDCTRL_TEST_SIM_CLKS

assign led[0] = clk_locked;
assign led[1] = rst_n_combined_ff;
assign led[2] = test_sys_rst_n;
assign led[3] = test_running;
assign led[4] = test_done;
assign led[5] = test_timeout;
assign led[7:6] = {2{test_passed}};

//////////////////////////
// Sub-module Instances //
//////////////////////////

`ifndef PITON_SDCTRL_TEST_SIM_CLKS
clk_mmcm_memio_unit_tests clk_mmcm_memio_unit_tests (
`ifdef PITON_CHIPSET_DIFF_CLK
    .clk_in1_p(clk_osc_p),
    .clk_in1_n(clk_osc_n),
`else // ifndef PITON_CHIPSET_DIFF_CLK
    .clk_in1(clk_osc),
`endif // PITON_CHIPSET_DIFF_CLK

    .reset(1'b0),
    .locked(clk_locked),

    .test_sys_clk(test_sys_clk),
    .spi_sys_clk(spi_sys_clk)
);
`endif // PITON_SDCTRL_TEST_SIM_CLKS

// Sequential test driver
mem_test_seq_driver mem_test_seq_driver (
    .clk(test_sys_clk),
    .rst_n(test_sys_rst_n),
    .en(test_seq_en),

    .test_mode_en(test_mode_en[2:0]),

    .addr_mode(sw[ADDRESSING_MODE_BITS_HI:ADDRESSING_MODE_BITS_LO]),
    .addr_incr_val(addr_incr_val),
    .data_payload_flits(data_payload_flits),
    .mem_top_addr(mem_top_addr),

    .test_mem_val(seq_test_sd_val),
    .test_mem_data(seq_test_sd_data),
    .test_mem_rdy(test_sd_rdy),

    .mem_test_val(sd_test_val),
    .mem_test_data(sd_test_data),
    .mem_test_rdy(seq_sd_test_rdy),

    .test_running(seq_test_running),
    .test_done(seq_test_done),
    .test_timeout(seq_test_timeout),
    .test_passed(seq_test_passed)
);

// Parallel test driver
mem_test_par_driver mem_test_par_driver (
    .clk(test_sys_clk),
    .rst_n(test_sys_rst_n),
    .en(test_par_en),

    .test_mode_en(test_mode_en[4:3]),

    .addr_mode(sw[ADDRESSING_MODE_BITS_HI:ADDRESSING_MODE_BITS_LO]),
    .addr_incr_val(addr_incr_val),
    .data_payload_flits(data_payload_flits),
    .mem_top_addr(mem_top_addr),

    .test_mem_val(par_test_sd_val),
    .test_mem_data(par_test_sd_data),
    .test_mem_rdy(test_sd_rdy),

    .mem_test_val(sd_test_val),
    .mem_test_data(sd_test_data),
    .mem_test_rdy(par_sd_test_rdy),

    .test_running(par_test_running),
    .test_done(par_test_done),
    .test_timeout(par_test_timeout),
    .test_passed(par_test_passed)
);

// Bridge between NoCs and SD card AXI interface
noc_axilite_bridge #(
    .SLAVE_RESP_BYTEWIDTH (8)
) noc_sd_bridge (
    .clk                  (test_sys_clk),
    .rst                  (~test_sys_rst_n),

    .splitter_bridge_val  (test_sd_val),
    .splitter_bridge_data (test_sd_data),
    .bridge_splitter_rdy  (test_sd_rdy),

    .bridge_splitter_val  (sd_test_val),
    .bridge_splitter_data (sd_test_data),
    .splitter_bridge_rdy  (sd_test_rdy),

    .m_axi_awaddr         (converter_sd_aw_addr),
    .m_axi_awvalid        (converter_sd_aw_valid),
    .m_axi_awready        (converter_sd_aw_ready),

    .m_axi_wdata          (converter_sd_w_data),
    .m_axi_wstrb          (converter_sd_w_strb),
    .m_axi_wvalid         (converter_sd_w_valid),
    .m_axi_wready         (converter_sd_w_ready),

    .m_axi_araddr         (converter_sd_ar_addr),
    .m_axi_arvalid        (converter_sd_ar_valid),
    .m_axi_arready        (converter_sd_ar_ready),

    .m_axi_rdata          (sd_converter_r_data),
    .m_axi_rresp          (sd_converter_r_resp),
    .m_axi_rvalid         (sd_converter_r_valid),
    .m_axi_rready         (sd_converter_r_ready),

    .m_axi_bresp          (sd_converter_b_resp),
    .m_axi_bvalid         (sd_converter_b_valid),
    .m_axi_bready         (sd_converter_b_ready)
);

// Bridge between AXI-Lite and SD Wishbone controller
axi_sd_bridge axi_sd_bridge (
    .clk           (test_sys_clk),
    .rst           (~test_sys_rst_n),

    .s_axi_awaddr  (converter_sd_aw_addr),
    .s_axi_awvalid (converter_sd_aw_valid),
    .s_axi_awready (converter_sd_aw_ready),

    .s_axi_wdata   (converter_sd_w_data),
    .s_axi_wstrb   (converter_sd_w_strb),
    .s_axi_wvalid  (converter_sd_w_valid),
    .s_axi_wready  (converter_sd_w_ready),

    .s_axi_araddr  (converter_sd_ar_addr),
    .s_axi_arvalid (converter_sd_ar_valid),
    .s_axi_arready (converter_sd_ar_ready),

    .s_axi_rdata   (sd_converter_r_data),
    .s_axi_rresp   (sd_converter_r_resp),
    .s_axi_rvalid  (sd_converter_r_valid),
    .s_axi_rready  (sd_converter_r_ready),

    .s_axi_bresp   (sd_converter_b_resp),
    .s_axi_bvalid  (sd_converter_b_valid),
    .s_axi_bready  (sd_converter_b_ready),

    .ack_i         (wb_ack),
    .dat_i         (wb_dat_i),
    .adr_o         (wb_adr),
    .dat_o         (wb_dat_o),
    .stb_o         (wb_stb),
    .we_o          (wb_we)
);

// Wishbone slave to SPI master for SD card
spi_master sd_master (
    .clk_i        (test_sys_clk),
    .rst_i        (~test_sys_rst_n),

    .adr_i        (wb_adr),
    .dat_i        (wb_dat_o),
    .stb_i        (wb_stb),
    .we_i         (wb_we),
    .ack_o        (wb_ack),
    .dat_o        (wb_dat_i),

    .spi_sys_clk  (spi_sys_clk),
    .spi_data_in  (spi_data_in),
    .spi_clk_out  (spi_clk_out),
    .spi_data_out (spi_data_out),
    .spi_cs_n     (spi_cs_n)
);

endmodule
