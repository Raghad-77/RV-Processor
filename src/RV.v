module RV(input clk,arst);
wire [31:0] SrcA,SrcB,ALUResult,ImmExt,PC,Instr,Result,WriteData,ReadData;
wire ZF,SF,PCSrc,RegWrite,MemWrite,ALUSrc,ResultSrc,load;
wire[2:0] ALUControl;
wire[1:0]ImmSrc;


ALU top_ALU(.SrcA(SrcA),.SrcB(SrcB),.SF(SF),.ZF(ZF),
.ALUResult(ALUResult),.ALUControl(ALUControl));

PC top_PC(.ImmExt(ImmExt),.PCSrc(PCSrc),
.clk(clk),.rst(arst),.load(1'b1),.PC(PC));

Imem top_Imem(.A(PC),.RD(Instr));

Register_File top_Register_File(
    .clk(clk),
    .rst(arst),
    .A1(Instr[19:15]),
    .A2(Instr[24:20]),
    .A3(Instr[11:7]),
    .WD3(Result),
    .WE3(RegWrite),
    .RD1(SrcA),
    .RD2(WriteData));

Data_mem top_Data_mem(.clk(clk),.WE(MemWrite),.A(ALUResult),
.WD(WriteData),.RD(ReadData));

CU top_CU(
    .op(Instr[6:0]),
    .funct3(Instr[14:12]),
    .funct7(Instr[30]),
    .ZF(ZF),.SF(SF),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .PCsrc(PCSrc), 
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl));

Sign_Extend top_Sign_Extend(.ImmSrc(ImmSrc), 
.Instr(Instr[31:7]),.ImmExt(ImmExt));

//mux
assign Result= ResultSrc? ReadData : ALUResult;
assign SrcB= ALUSrc? ImmExt : WriteData;

endmodule