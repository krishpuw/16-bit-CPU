`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 07:57:29 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [15:0] a,
    input [15:0] b,
    input [2:0] alu_control,
    output reg zero,
    output reg [15:0] result
    );
    //0 - add
    //1 - sub
    //2 - sll
    //3 - and
    //else result == 0

always@(*) 
begin
    if (alu_control == 0) begin
        result = a + b;
   end
   else if(alu_control == 1) begin
        result = a - b;
   end
   else if(alu_control == 2) begin
        result = a << b[3:0];
   end
   else if(alu_control == 3) begin
        result = a & b;
   end
   else begin
        result = 0;
   end
    
   if (result == 0) begin
        zero = 1;
   end
   else begin
        zero = 0;
   end
end
endmodule
