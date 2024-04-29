`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:08:25
// Design Name: 
// Module Name: PCPlusOffsetAdder
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


module PCPlusOffsetAdder(
//input clk_cpu,
input[31:0] Imm,
input[31:0] AddrIn,
output [31:0] AddrOut

    );
//    always@(posedge clk_cpu)
//    begin
assign  AddrOut=Imm+AddrIn;
 // end
    
    
endmodule