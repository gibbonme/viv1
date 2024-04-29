`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 22:59:33
// Design Name: 
// Module Name: PC
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


module PC(input[31:0] addrIn,
input rstn,
input clk_cpu,
output reg[31:0]addrOut);
parameter PC_NUM=20;

initial
begin
addrOut<=32'b0;
end

always@(posedge clk_cpu or negedge rstn)
begin
if(!rstn) begin 
        addrOut <= 32'b0;
    end
 else 
    begin
     addrOut<=addrIn;
 end 
end  

    
endmodule

