module Data_mem(
    input clk,
    input WE,
    input [31:0]A,WD,
    output reg [31:0]RD
);
reg [31:0] Dmem [0:63];    // Depth=64, Width=32

always @(*) begin
    RD=Dmem[A[7:2]];  //read
end

always @(posedge clk) begin 
     if (WE)   
        Dmem[A[7:2]] <= WD; //write
end
endmodule