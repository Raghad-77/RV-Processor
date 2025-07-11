module Sign_Extend(
    input [1:0]ImmSrc,
    input [24:0] Instr, 
    output reg [31:0] ImmExt
);
always @(*) begin
    case (ImmSrc)
        2'b00: ImmExt = {{20{Instr[24]}}, Instr[24:13]};  // I-type
        2'b01: ImmExt = {{20{Instr[24]}}, Instr[24:18], Instr[4:0]}; // S-type
        2'b10: ImmExt = {{20{Instr[24]}},Instr[0],Instr[24:18], Instr[4:1], 1'b0}; // B-type

        default:  ImmExt = 32'b0;
    endcase
end
endmodule