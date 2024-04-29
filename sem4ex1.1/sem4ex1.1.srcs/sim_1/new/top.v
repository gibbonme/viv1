`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/25 20:06:52
// Design Name: 
// Module Name: top
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


module top(  );
reg clkIn;
reg rstIn;
reg [15:0] sw_i;
initial begin clkIn=0; forever #1 clkIn=~clkIn; end
initial begin rstIn=1;#1 rstIn=~rstIn; #1 rstIn=~rstIn ;end
initial begin sw_i=16'b0000000000000010;end

sccomp u_sccomp(
.clk(clkIn),
.rstn(rstIn),
.sw_i(sw_i),
.disp_an_o(), 
.disp_seg_o()
);

endmodule

