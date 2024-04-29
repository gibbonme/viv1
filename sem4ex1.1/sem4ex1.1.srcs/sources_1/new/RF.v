`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/13 23:36:25
// Design Name: 
// Module Name: RF
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


module RF(
input clk,
input rstn,
input RFWr,//0 Notwrite,1 Write
input [4:0] A1,A2,A3,
input [31:0] WD,
output [31:0] RD1, RD2
    );    
reg [31:0] rf[31:0];
integer i;
initial 
begin
    for(i=0;i<32;i=i+1)rf[i]=1'b0;
end
assign RD1 = (A1==0)?0:rf[A1]; 
assign RD2 = (A2==0)?0:rf[A2]; 
//posedge clk or negedge rstn
always@(posedge clk or negedge rstn) begin
    if(!rstn) begin 
        for(i=0;i<32;i=i+1)rf[i]<=1'b0;
    end
    else if(RFWr&&(A3!=0))begin
        rf[A3] <= WD;
    end
end
endmodule