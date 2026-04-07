`timescale 1ns / 1ps

module pc_tb();

reg clk;
reg reset;
reg [15:0] inputpc;
wire [15:0] outputpc;
pc uut (
        .clk(clk),
        .reset(reset),
        .outputpc(outputpc),
        .inputpc(inputpc)
    );

always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;
    inputpc = 16'h0000;
       
    #10;
    reset = 0;
    #10;
    inputpc = 16'h0100;
    #10;
    inputpc = 16'h0101;
    #20;
end

endmodule