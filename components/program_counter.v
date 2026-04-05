`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 02:34:32 PM
// Design Name: 
// Module Name: pc
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


module pc(
    input wire clk,
    input wire reset ,
    output reg[15:0] outputpc,
    input wire[15:0] inputpc 

    );
    
    always @(posedge clk)
    begin 
    if (reset) begin
        outputpc <= 16'h0000;
    end
    else 
        outputpc <= inputpc +16'd2; //  pc+2
    end 
 

endmodule
