module PC(
    input [31:0] ImmExt,
    input PCSrc,
    input clk,rst,load,
    output reg [31:0] PC
);

wire [31:0] PCNext;
assign PCNext = PCSrc ? (PC + ImmExt) : (PC + 32'd4);

always @(posedge clk or negedge rst) begin
    if(!rst)
       PC<=32'b0; 
    else if(load)
       PC<=PCNext; 
    else 
       PC<=PC; 
end
endmodule