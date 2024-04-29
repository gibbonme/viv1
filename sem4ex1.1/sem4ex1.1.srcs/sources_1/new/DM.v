`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:10:43
// Design Name: 
// Module Name: DM
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

module DM(
input clk,
input rstn,
input DMWr, 
input DMRd, 
input [31:0]			addr,
input [31:0]			din,
output  [31:0]		dout
    );
reg [31:0] dmem[31:0];
integer i;

initial  begin 
for(i=0;i<32;i=i+1)dmem[i]=1'b0;
end
//
always@(posedge clk or negedge rstn) begin
    if(!rstn) begin 
        for(i=0;i<32;i=i+1)dmem[i]<=0;
        end
     else if(DMWr) 
         begin
        dmem[addr]<=din[31:0];
//        dmem[addr+1]<=din[15:8];
//        dmem[addr+2]<=din[23:16];
//        dmem[addr+3]<=din[31:24]; 
          end
      end
//存疑，写内存需不需要时钟周期      
//always @(*)begin
//if (DMRd) begin
 assign dout=dmem[addr];
// end
//     end
endmodule

