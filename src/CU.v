module CU(
    input [6:0]op,
    input [2:0]funct3,
    input funct7,ZF,SF,
    output reg RegWrite,ALUSrc,MemWrite,ResultSrc,PCsrc,
    output reg [1:0]ImmSrc,
    output reg [2:0]ALUControl
);

reg Branch;
reg [1:0] ALUOp;

//main decoder  
always @(*) begin
    case (op) 

    7'b0000011: begin //loadWord
    RegWrite = 1'b1; 
    ImmSrc = 2'b00; 
    ALUSrc = 1'b1; 
    MemWrite = 1'b0;
    ResultSrc = 1'b1; 
    Branch = 1'b0; 
    ALUOp = 2'b00;
    end 

    7'b0100011: begin //storeWord
    RegWrite = 1'b0; 
    ImmSrc = 2'b01; 
    ALUSrc = 1'b1; 
    MemWrite = 1'b1;
    Branch = 1'b0; 
    ALUOp = 2'b00;
    end 

    7'b0110011: begin //R-Type
    RegWrite = 1'b1; 
    ALUSrc = 1'b0; 
    MemWrite = 1'b0;
    ResultSrc = 1'b0; 
    Branch = 1'b0; 
    ALUOp = 2'b10;
    end 

    7'b0010011: begin //I-Type
    RegWrite = 1'b1; 
    ImmSrc = 2'b00; 
    ALUSrc = 1'b1; 
    MemWrite = 1'b0;
    ResultSrc = 1'b0; 
    Branch = 1'b0; 
    ALUOp = 2'b10;
    end

    7'b1100011: begin //branch-instructions
    RegWrite = 1'b0; 
    ImmSrc = 2'b10; 
    ALUSrc = 1'b0; 
    MemWrite = 1'b0;
    Branch = 1'b1; 
    ALUOp = 2'b01;
    end 

    default: begin //default values 
    RegWrite = 1'b0; ImmSrc = 2'b00; ALUSrc = 1'b0; MemWrite = 1'b0;
    ResultSrc = 1'b0; Branch = 1'b0; ALUOp = 2'b00;
    end

    endcase
end

//ALU decoder 
always @(*) begin
    case(ALUOp)

    2'b00: ALUControl=3'b000; //add --> lw,sw

    2'b01: ALUControl=3'b010; // sub --> branches
    
    2'b10:begin
        case (funct3)
            3'b000: ALUControl = (funct7 == 1 && op[5]==1) ? 3'b010:3'b000 ; // add or sub
            3'b001: ALUControl = 3'b001; // shift left
            3'b100: ALUControl = 3'b100; // xor
            3'b101: ALUControl = 3'b101; // shift right
            3'b110: ALUControl = 3'b110; // or
            3'b111: ALUControl = 3'b111; // and
            
            default: ALUControl = 3'b000; 
        endcase
    end

    endcase  
end

always @(*) begin
    case (funct3)
        3'b000: PCsrc = Branch & ZF;     // BEQ
        3'b001: PCsrc = Branch & ~ZF;    // BNE
        3'b100: PCsrc = Branch & SF;     // BLT
        default: PCsrc = 0;
    endcase
end

endmodule