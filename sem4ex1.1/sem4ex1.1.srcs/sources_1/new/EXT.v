`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 22:58:45
// Design Name: 
// Module Name: EXT
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


`define EXT_CTRL_ITYPE_1  3'b000
`define EXT_CTRL_ITYPE_2  3'b001
`define EXT_CTRL_UTYPE       3'b010
`define EXT_CTRL_STYPE    3'b011
`define EXT_CTRL_SBTYPE       3'b100
`define EXT_CTRL_UJTYPE   3'b101
`define EXT_CTRL_ELSETYPE 3'b111

module EXT(
       input [31:0] instr,
       input [2:0] EXTOp,
       output reg [31:0] immout
    );
    always@(*)
    begin
        case(EXTOp)
        `EXT_CTRL_ITYPE_1: immout<={{20{instr[31]}},instr[31:20]};
        `EXT_CTRL_ITYPE_2: immout<={{26{instr[25]}},instr[25:20]};
        `EXT_CTRL_UTYPE: immout<={{12{instr[31]}},instr[31:12]};
        `EXT_CTRL_STYPE: immout<={{20{instr[31]}},instr[31:25],instr[11:7]};
        `EXT_CTRL_SBTYPE: immout<={{20{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8]};
        `EXT_CTRL_UJTYPE: immout<={{12{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21]};
        default: immout <= 32'b0;
        endcase
    end
endmodule

