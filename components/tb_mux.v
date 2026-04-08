`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 08:23:15 PM
// Design Name: 
// Module Name: tb_mux
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


module tb_mux;

    reg [15:0] a;
    reg [15:0] b;
    reg select;

    wire [15:0] out;

    Multiplexer uut (
        .a(a),
        .b(b),
        .select(select),
        .out(out)
    );

    initial begin
        
        a = 10;
        b = 5;
        select = 0;
        #10;
        a = 10;
        b = 5;
        select = 1;
        #10;
        
        a = 25;
        b = 100;
        select = 0;
        #10;
        a = 25;
        b = 100;
        select = 1;
        #10;
        
        a = 0;
        b = 0;
        select = 0;
        #10;
        
        a = 0;
        b = 0;
        select = 1;
        #10;

       
        $stop;
    end

endmodule
