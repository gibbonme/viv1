`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/19 09:21:03
// Design Name: 
// Module Name: alu
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
// ALU control signal
module alu_mux( 
  input[31:0]  RD2, 
  input[31:0] immout,    
  input ALUSrc,       
  output[31:0] B);  
  assign B=ALUSrc?immout: RD2;//�����ź�Ϊ1��ѡ����������Ϊ0ѡ��Ĵ���
endmodule
        