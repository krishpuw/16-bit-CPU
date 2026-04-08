`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 08:17:37 PM
// Design Name: 
// Module Name: tb_data_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_data_memory;

    
    reg clk;
    reg [15:0] address;
    reg [15:0] writedata;
    reg memwrite;
    reg memread;

    wire [15:0] readdata;
    
    data_memory uut (
        .clk(clk),
        .address(address),
        .writedata(writedata),
        .memwrite(memwrite),
        .memread(memread),
        .readdata(readdata)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        

        address = 0;
        writedata = 0;
        memwrite = 0;
        memread = 0;
        #10;

        address = 8;
        writedata = 16'hABCD;
        memwrite = 1; memread = 0;
        #10;          
        memwrite = 0; memread = 1;
        #10;         

        memread = 0;
        address = 20;
        writedata = 16'h1234;
        memwrite = 1;
        #10;
        memwrite = 0; memread = 1;
        #10;

        memread = 0;
        #10;          

        $stop;
    end

endmodule
