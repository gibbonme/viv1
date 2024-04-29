`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:10:03
// Design Name: 
// Module Name: addr_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define PC_res 3'b000
`define PC_beq 3'b001
`define PC_blt 3'b010
`define PC_nom 3'b011
`define PC_jal 3'b100

module addr_mux(
input Less,
input Zero,
input[31:0] Res,
input[31:0] PCReladdr,
input[31:0] SeqAddr,
input[2:0] AdSel, 
output reg[31:0] Addr
    );
    always@(*)
    begin
    case(AdSel)
      `PC_res:Addr<=Res;
      `PC_beq:
      begin
      if(Zero)
      begin Addr<=PCReladdr;end
      else begin Addr<=SeqAddr;end
      end
      `PC_blt:
      begin
      if(Less)
      begin Addr<=PCReladdr;end
      else begin Addr<=SeqAddr;end
      end
      `PC_nom:Addr<=SeqAddr;
      `PC_jal:Addr<=PCReladdr;
      default:Addr<=SeqAddr;
      endcase
      end
endmodule