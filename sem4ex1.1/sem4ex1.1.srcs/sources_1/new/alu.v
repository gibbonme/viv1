`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 23:04:55
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


`define ALU_ADD   3'b000 
`define ALU_SUB   3'b001
`define ALU_AND   3'b010 
`define ALU_OR    3'b011
`define ALU_XOR   3'b100
`define ALU_SLL   3'b101
`define ALU_SRL   3'b110

module alu(
    input signed[31:0] Data1,Data2,//ALU input
    input [2:0] ALU,//alu how to do
    output reg  Less,//alu result
    output reg  Zero,
    output reg signed[31:0] Result
    );
     always@(*)begin
        case(ALU)
            `ALU_ADD: begin 
            Result = Data1 + Data2;
            end
            `ALU_SUB: begin 
            Result = Data1 - Data2;
            end
            `ALU_AND: begin 
            Result=(Data1&Data2);
            end
            `ALU_OR:begin 
            Result=(Data1|Data2);
             end
            `ALU_XOR:begin 
            Result=(Data1^Data2);
            end
            `ALU_SLL:begin 
            Result=(Data1<<Data2);
            end
            `ALU_SRL:begin 
            Result=(Data1>>Data2);
            end
            default:Result = 32'hFFFFFFFF;            
        endcase
        Zero =( Result==0) ? 1'b1 : 1'b0; 
        Less = (Result<0 )? 1'b1 : 1'b0;
end
endmodule
        
        
