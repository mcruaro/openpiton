// DESCRIPTION: Verilator: Verilog Test module

module t;
   // Test turning on and off a message on the same line; only middle reg shouldn't warn
   reg [0:1] show1; /*verilator lint_off LITENDIAN*/ reg [0:2] ign2; /*verilator lint_on LITENDIAN*/  reg [0:3] show3;
   initial begin
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
