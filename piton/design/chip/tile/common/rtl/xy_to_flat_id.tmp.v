/*
Copyright (c) 2015 Princeton University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Princeton University nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`include "l15.tmp.h"
`include "define.tmp.h"

// /home/ruaro/openpiton/piton/verif/env/manycore/devices_ariane.xml



module xy_to_flat_id(
    input  [(`NOC_X_WIDTH-1):0] x_coord,
    input  [(`NOC_Y_WIDTH-1):0] y_coord,
    output reg [(`HOME_ID_WIDTH-1):0] flat_id
);
    
    
    always @*
    begin
        case (x_coord)
        
`NOC_X_WIDTH'd0:
begin
     case (y_coord)

    // (x,y) = (0, 0)
    `NOC_Y_WIDTH'd0:
    begin
        flat_id = `HOME_ID_WIDTH'd0;
    end
     default:
     begin
         flat_id = `HOME_ID_WIDTH'dX;
     end
     endcase
end

`NOC_X_WIDTH'd1:
begin
     case (y_coord)

    // (x,y) = (1, 0)
    `NOC_Y_WIDTH'd0:
    begin
        flat_id = `HOME_ID_WIDTH'd1;
    end
     default:
     begin
         flat_id = `HOME_ID_WIDTH'dX;
     end
     endcase
end

        default:
        begin
            flat_id = `HOME_ID_WIDTH'dX;
        end
        endcase
    end
endmodule

