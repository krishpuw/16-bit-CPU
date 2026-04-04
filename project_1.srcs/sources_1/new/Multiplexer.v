`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 07:02:44 PM
// Design Name: 
// Module Name: Multiplexer
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


module Multiplexer(
    input [15:0] a,
    input [15:0] b,
    input select,
    output reg [15:0] out
    );
always@(a,b,select) 
begin
    if(select == 1)begin
        out = a;
    end
    else begin
        out = b;
    end
end 
endmodule
