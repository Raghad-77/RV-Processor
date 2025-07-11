module ALU(
input [31:0] SrcA,SrcB,
output reg SF,ZF,
output reg [31:0]ALUResult,
input [2:0]ALUControl
);

always@(*) 
begin
    case (ALUControl)
    3'b000:  ALUResult=SrcA+SrcB; 
    3'b001:  ALUResult=SrcA<<SrcB; //shift left
    3'b010:  ALUResult=SrcA-SrcB; 
    3'b100:  ALUResult=SrcA^SrcB; 
    3'b101:  ALUResult=SrcA>>SrcB; //shift right
    3'b110:  ALUResult=SrcA|SrcB; 
    3'b111:  ALUResult=SrcA&SrcB; 
    default: begin ALUResult=0; SF=0; ZF=1; end
    endcase
    SF = ALUResult[31];
    if (ALUResult==0) ZF=1;
    else ZF=0;

end

endmodule