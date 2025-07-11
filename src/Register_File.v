module Register_File( //32 registers,Each register is 32 bits wide 
    input clk,rst,
    input [4:0] A1,A2,A3,
    input [31:0]WD3,
    input WE3,
    output reg [31:0]RD1,RD2
);
reg [31:0] registers[0:31];

always @(*) begin // Asynchronous read ports
    RD1 =registers[A1];  
    RD2 =registers[A2];  
end

integer i;
always @(posedge clk or negedge rst) begin // Synchronous write with asynchronous reset
    if (!rst) begin
        for (i = 0; i < 32; i = i + 1) 
            registers[i] <= 32'b0;
    end
    else if (WE3) begin  // Write on rising clock edge 
        registers[A3] <= WD3;
    end
end
endmodule