`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:09:23
// Design Name: 
// Module Name: PCPlusAdder
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


module PCPlusAdder(
//input clk_cpu,
input[31:0] AddrIn,
output [31:0] AddrOut
);
//    always@(posedge clk_cpu)
//    begin
 assign  AddrOut=AddrIn+1'b1;
//end
endmodule
