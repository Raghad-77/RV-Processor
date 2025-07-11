module Imem#(parameter width =32 , depth=64)
(
    input [width-1:0] A,        
    output reg [width-1:0] RD   
);
reg [width-1:0] mem [0:depth-1]; //64 registers,each 32 bit wide

initial begin
    $readmemh("program.txt", mem);
end

always @(*) begin
    RD = mem[A[7:2]];     
end
endmodule
