`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 09:16:49 PM
// Design Name: 
// Module Name: regfile_tb
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


module regfile_tb;

    reg        clk;
    reg        reset;
    reg [7:4]  read_reg1;
    reg [11:8] read_reg2;
    reg [3:0]  write_reg;
    reg [15:0] write_data;
    reg        reg_write;

    wire [15:0] read_data1;
    wire [15:0] read_data2;

    register_file uut (
        .clk        (clk),
        .reset      (reset),
        .read_reg1  (read_reg1),
        .read_data1 (read_data1),
        .read_reg2  (read_reg2),
        .read_data2 (read_data2),
        .write_reg  (write_reg),
        .write_data (write_data),
        .reg_write  (reg_write)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t | reset=%b reg_write=%b write_reg=%0d write_data=%0d | read_reg1=%0d read_data1=%0d | read_reg2=%0d read_data2=%0d",
                  $time, reset, reg_write, write_reg, write_data,
                  read_reg1, read_data1, read_reg2, read_data2);

        reset      = 1;
        reg_write  = 0;
        write_reg  = 4'd0;
        write_data = 16'd0;
        read_reg1  = 4'd0;
        read_reg2  = 4'd0;

        @(posedge clk); #1;
        @(posedge clk); #1;
        reset = 0;

        write_reg  = 4'd3;
        write_data = 16'd42;
        reg_write  = 1;
        @(posedge clk); #1;
        reg_write  = 0;
        read_reg1  = 4'd3;
        read_reg2  = 4'd3;
        #1;
        $finish;
        end

endmodule
