`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:11:23
// Design Name: 
// Module Name: data_mux
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
`define WD_Res 2'b00
`define WD_Imm 2'b01
`define WD_Fdm 2'b10
`define WD_Sad 2'b11


module data_mux(
//input clk,
input[31:0] Res,
input[31:0] Imm, 
input[31:0] Dm,
input[31:0] SeqAd,
input[1:0] DSel,
output reg[31:0] DataOut
    );
    always@(*)
    begin
    case(DSel)
    `WD_Res:DataOut<=Res;
    `WD_Imm:DataOut<=Imm;
    `WD_Fdm:DataOut<=Dm;
    `WD_Sad:DataOut<=SeqAd;
    default:DataOut<=32'h00000000;
    endcase
    end
endmodule