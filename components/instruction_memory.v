`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2026 05:16:42 PM
// Design Name: 
// Module Name: instruction_memory
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

module instruction_memory (
    input  wire [15:0] address,      // byte addr from pc
    output wire [15:0] instruction
);

    // memory array is 256 bytes and instruct is at EVEN addresses (each spans 2 bytes)
    reg [7:0] mem [0:255];

    initial begin
        // program.mem is just a placeholder located at project_1.sim/sim_1/behav/xsim/
        $readmemh("program.mem", mem);
    end

    // instructions stored as big-endian, heres an example
    // addr 0x00: addi $s1, $s0, 5   (16'h3105)
    // mem[8'h00] = 8'h31; mem[8'h01] = 8'h05;

    // async read - fetch two bytes and combine big-endian, address must be word-aligned (even) and address[0] is ignored
    assign instruction = {mem[address], mem[address + 16'd1]};

endmodule