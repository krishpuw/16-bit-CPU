`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2026 03:22:49 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input wire [1:0] aluop,
    input wire [2:0] funct,
    output reg [2:0] alu_control
    );
    
    
    always @(*) begin
    case (aluop)
        2'b00: alu_control = 3'b000; // add

        2'b01: alu_control = 3'b001; // sub

        2'b10: begin // r type
            case (funct)
                3'b000: alu_control = 3'b000; // add
                3'b001: alu_control = 3'b001; // sub
                3'b010: alu_control = 3'b010; // sll
                3'b011: alu_control = 3'b011; // and
                default: alu_control = 3'b000;
            endcase
        end

        default: alu_control = 3'b000;
    endcase
end
endmodule
