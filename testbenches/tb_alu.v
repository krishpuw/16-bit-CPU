`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 08:05:56 PM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu;
    
    reg [15:0] a;
    reg [15:0] b;
    reg [2:0] alu_control;

    wire zero;
    wire [15:0] result;

    
    ALU uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .zero(zero),
        .result(result)
    );

    
    initial begin
    
        alu_control = 3'b000;
        a = 10;
        b = 5;
        #10;
        
        alu_control = 3'b000;
        a = 0;
        b = 0;
        #10;
        
        alu_control = 3'b001;
        a = 10;
        b = 5;
        #10;
        
        alu_control = 3'b001;
        a = 5;
        b = 5;
        #10;
        
        alu_control = 3'b010;
        a = 3;
        b = 2;
        #10;
        
        alu_control = 3'b010;
        a = 1;
        b = 4;
        #10;
        
        alu_control = 3'b011;
        a = 6;
        b = 3;
        #10;
        
        alu_control = 3'b011;
        a = 5;
        b = 2;
        #10;
        
        alu_control = 3'b100;
        a = 7;
        b = 3;
        #10;
        $stop;
    end

endmodule
