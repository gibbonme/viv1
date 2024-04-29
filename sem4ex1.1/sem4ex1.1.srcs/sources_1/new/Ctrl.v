`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 22:58:02
// Design Name: 
// Module Name: Ctrl
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


module Ctrl(input[6:0] Op,
output rw,
output ALUS,
output [2:0]ALUop,
output [2:0]AddrS, 
output MR,
output MW,
output [1:0]DataSe,
output [2:0]extImm
);
reg[14:0] ctrlSignalOut;
always@(*) begin
case(Op)
7'b0000001:ctrlSignalOut<=15'b100000110000111;//add
7'b0000010:ctrlSignalOut<=15'b110000110000000;//addi
7'b0000011:ctrlSignalOut<=15'b100010110000111;//sub
7'b0000100:ctrlSignalOut<=15'b100100110000111;//and
7'b0000101:ctrlSignalOut<=15'b110100110000000;//andi
7'b0000110:ctrlSignalOut<=15'b100110110000111;//or
7'b0000111:ctrlSignalOut<=15'b110110110000000;//ori
7'b0001000:ctrlSignalOut<=15'b101000110000111;//xor
7'b0001001:ctrlSignalOut<=15'b111000110000000;//xori
7'b0001010:ctrlSignalOut<=15'b101010110000111;//sll
7'b0001011:ctrlSignalOut<=15'b111010110000001;//slli
7'b0001100:ctrlSignalOut<=15'b101100110000111;//srl
7'b0001101:ctrlSignalOut<=15'b111100110000001;//srli
7'b0001110:ctrlSignalOut<=15'b111110110001010;//lui
7'b0001111:ctrlSignalOut<=15'b110000111010000;//lw改
7'b0010000:ctrlSignalOut<=15'b010000110100011;//sw改
7'b0010001:ctrlSignalOut<=15'b000010100000100;//blt
7'b0010010:ctrlSignalOut<=15'b000010010000100;//beq
7'b0010011:ctrlSignalOut<=15'b110001000011101;//jal
7'b0010100:ctrlSignalOut<=15'b110000000011000;//jalr
endcase
end
//添加opcode
//名称位数：位：
//RW1[14] 
//ALUS1:ctrlSignalOut[13] 
//ALUop3:ctrlSignalOut[12:10] 
//AddrS3:ctrlSignalOut[9:7] 
//MR1:ctrlSignalOut[6] 
//MW1:ctrlSignalOut[5] 
//DataSe2:ctrlSignalOut[4:3] 
//extImm3:ctrlSignalOut[2:0]
assign rw=ctrlSignalOut[14];
assign ALUS=ctrlSignalOut[13];
assign ALUop=ctrlSignalOut[12:10];
assign AddrS= ctrlSignalOut[9:7];
assign MR=ctrlSignalOut[6];
assign MW=ctrlSignalOut[5];
assign DataSe=ctrlSignalOut[4:3];
assign extImm=ctrlSignalOut[2:0];

endmodule
