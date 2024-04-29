`timescale 1ns / 1ps
//主控模块

module sccomp(
input clk,
input rstn,
input [15:0] sw_i,
output [7:0] disp_an_o, disp_seg_o

);
reg [63:0]  display_data;    //8_to_1w

reg [31:0] clkdiv;
wire Clk_CPU;
reg[6:0] Op;

wire Less;
wire Zero;

reg[4:0] rs1,rs2;
reg[4:0] rd;
wire[31:0] WD;
reg [5:0] reg_addr;
reg [31:0]  reg_data;

reg[5:0]dmem_addr;
reg[31:0]  dmem_data;

wire [31:0] instr;
wire[31:0] dout;
wire[31:0]aluout;
wire [31:0] 	immout;

//有用
reg[2:0]alu_addr;
reg [31:0]  alu_disp_data;
wire [31:0]RD1;
wire [31:0]RD2;
wire [31:0] B;
wire[31:0]addrIn;//最终送入PC的
wire[31:0] addr;//PC送出的
wire[31:0] addrp;//PCRelAddr
wire[31:0] addrs;//SeqAddr


always@(posedge clk, negedge rstn) begin
    if(!rstn)
        clkdiv <= 0;
    else
        clkdiv <= clkdiv + 1'b1;
end
//作为频率的控制信号
assign Clk_CPU = (sw_i[15])?clkdiv[0]:clkdiv[0];
//assign Clk_CPU = (sw_i[15])?clkdiv[27]:clkdiv[25];
//sw_1控制开始和暂停
wire Clk_CPU_In;
assign Clk_CPU_In=sw_i[1]?Clk_CPU:1'b0;

parameter   LED_DATA_NUM = 19 ,num_reg=32,DM_DATA_NUM = 32;
reg [63:0]  LED_DATA[18:0];


//开关1控制启动

//wire [5:0] rom_addr;
//assign rom_addr=addr;

//RF
//开关11控制显示寄存器
always@(posedge Clk_CPU or negedge rstn) begin
    if(!rstn) begin 
        reg_addr = 6'b0;
    end
    else if(sw_i[11]) begin
    if(reg_addr==num_reg)begin
        reg_addr=0;
        reg_data=32'hFFFFFFFF;
    end
    else begin
        reg_data = U_RF.rf[reg_addr];
        reg_addr = reg_addr + 1'b1;
        end
    end
end

//DM
//开关12控制显示内存
always@(posedge Clk_CPU or negedge rstn) begin
    if(!rstn)begin
        dmem_addr=6'b0;
    end
    else if(sw_i[12])begin
if (dmem_addr == DM_DATA_NUM)
     begin
     dmem_addr = 0;
     dmem_data = 32'hFFFFFFFF;end
    
 else begin
    dmem_data =U_DM.dmem[dmem_addr];
    dmem_addr = dmem_addr + 1'b1;
     end 
     end 
end 

//开关13控制显示PC值
reg[31:0] PC_data;
always@(posedge Clk_CPU)
begin
PC_data=addr;
end
//开关14控制显示指令
always@(*) begin
    if(sw_i[1] == 1'b0) begin
       case(sw_i[14:11])
           
            4'b0010: display_data = dmem_data;
            4'b0001: display_data = reg_data;
            default: display_data = instr;
        endcase
    end
        else begin
        if(sw_i[1] == 1'b1) begin
         case(sw_i[14:11])
            4'b1000: display_data = U_PC.addrOut;
            4'b0100: display_data = U_RF.rf[1];
            4'b0010:  display_data =U_EXT .immout;
            4'b0001: display_data= PC_data;
            default: display_data = U_PCPlusOffsetAdder.AddrOut;
         endcase
        end
        else begin
            display_data =32'hFFFFFFFF;
        end
    end
end

//要增加控制模块
wire rw;
wire ALUS;
wire [2:0]ALUop;
wire [2:0]AddrS;
wire MR;
wire MW;
wire [1:0]DataSe;
wire [2:0]extImm;

//Decode
always@(*)begin
    Op = instr[6:0];  // op
    rs1 = instr[19:15];  // rs1
    rs2 = instr[24:20];  // rs2
    rd = instr[11:7];  // rd
end

seg7x16 u_seg7x16(
    .clk(clk),
    .rstn(rstn),
    .i_data(display_data),
    .disp_mode(sw_i[0]),
    .o_seg(disp_seg_o),
    .o_sel(disp_an_o)
);
dist_mem_im U_IM(
    .a(addr),
    .spo(instr)
); 

Ctrl U_Ctrl(Op,rw,ALUS,ALUop,AddrS,MR,MW,DataSe,extImm);
PC U_PC(.addrIn(addrIn),.rstn(rstn),.clk_cpu(Clk_CPU_In),.addrOut(addr));
RF U_RF(.clk(Clk_CPU),.rstn(rstn),.RFWr(rw),.A1(rs1),.A2(rs2),.A3(rd),.WD(WD),.RD1(RD1),.RD2(RD2));
EXT U_EXT(.instr(instr),.EXTOp(extImm),.immout(immout));
alu_mux U_alu_mux( .RD2(RD2),.immout(immout),.ALUSrc(ALUS),.B(B));
alu U_alu(.Data1(RD1),.Data2(B),.ALU(ALUop),.Less(Less),.Zero(Zero),.Result(aluout));
PCPlusOffsetAdder U_PCPlusOffsetAdder(.Imm(immout),.AddrIn(addr),.AddrOut(addrp));
PCPlusAdder U_PCPlusAdder(.AddrIn(addr),.AddrOut(addrs));
addr_mux U_addr_mux(.Less(Less),.Zero(Zero),.Res(aluout),.PCReladdr(addrp),.SeqAddr(addrs),.AdSel(AddrS),.Addr(addrIn));
DM U_DM(.clk(Clk_CPU),.rstn(rstn),.DMWr(MW),.DMRd(MR),.addr(aluout),.din(RD2),.dout(dout));
data_mux U_data_mux(.Res(aluout),.Imm(immout),.Dm(dout),.SeqAd(addrs),.DSel(DataSe),.DataOut(WD));

endmodule
