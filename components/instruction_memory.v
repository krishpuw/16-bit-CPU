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
    integer k;
    // memory array is 256 bytes and instruct is at EVEN addresses (each spans 2 bytes)
    reg [7:0] mem [0:255];

//    initial begin
        // program.mem is just a placeholder located at project_1.sim/sim_1/behav/xsim/
//        $readmemh("program.mem", mem);
//    end

    // instructions stored as big-endian, heres an example
    // addr 0x00: addi $s1, $s0, 5   (16'h3105)
    // mem[8'h00] = 8'h31; mem[8'h01] = 8'h05;
    
     initial begin
        // Zero out everything first
        
        for (k = 0; k < 256; k = k + 1) mem[k] = 8'h00;

        // PC=0:  0x3105  addi $s1, $s0, 5
        mem[8'h00]=8'h31; mem[8'h01]=8'h05;
        // PC=2:  0x3206  addi $s2, $s0, 6
        mem[8'h02]=8'h32; mem[8'h03]=8'h06;
        // PC=4:  0x3303  addi $s3, $s0, 3
        mem[8'h04]=8'h33; mem[8'h05]=8'h03;
        // PC=6:  0x0230
        mem[8'h06]=8'h02; mem[8'h07]=8'h30;
        // PC=8:  0x0231
        mem[8'h08]=8'h02; mem[8'h09]=8'h31;
        // PC=10: 0x0123
        mem[8'h0A]=8'h01; mem[8'h0B]=8'h23;
        // PC=12: 0x0232
        mem[8'h0C]=8'h02; mem[8'h0D]=8'h32;
        // PC=14: 0x2200
        mem[8'h0E]=8'h22; mem[8'h0F]=8'h00;
        // PC=16: 0x1400
        mem[8'h10]=8'h14; mem[8'h11]=8'h00;
        // PC=18: 0x4421 
        mem[8'h12]=8'h44; mem[8'h13]=8'h21;
        // PC=20: 
        mem[8'h14]=8'h00; mem[8'h15]=8'h00;
        // PC=22: 0x3507
        mem[8'h16]=8'h35; mem[8'h17]=8'h07;
        // PC=24: 0x5531
        mem[8'h18]=8'h55; mem[8'h19]=8'h31;
        // PC=26: 0x3609
        mem[8'h1A]=8'h36; mem[8'h1B]=8'h09;
        // PC=28: 0x3608
        mem[8'h1C]=8'h36; mem[8'h1D]=8'h08;
        // PC=30: 0x6001 
        mem[8'h1E]=8'h60; mem[8'h1F]=8'h01;
        // PC=32: 
        mem[8'h20]=8'h00; mem[8'h21]=8'h00;
        // PC=34: 0x3206
        mem[8'h22]=8'h32; mem[8'h23]=8'h06;
        // PC=36: 0x3303
        mem[8'h24]=8'h33; mem[8'h25]=8'h03;
        // PC=38: 0x0230
        mem[8'h26]=8'h02; mem[8'h27]=8'h30;
        // PC=40: 0x0231
        mem[8'h28]=8'h02; mem[8'h29]=8'h31;
        // PC=42: 0x0123
        mem[8'h2A]=8'h01; mem[8'h2B]=8'h23;
        // PC=44: 0x0232
        mem[8'h2C]=8'h02; mem[8'h2D]=8'h32;
        // PC=46: 0x2200
        mem[8'h2E]=8'h22; mem[8'h2F]=8'h00;
        // PC=48: 0x1400
        mem[8'h30]=8'h14; mem[8'h31]=8'h00;
    end
    // async read - fetch two bytes and combine big-endian, address must be word-aligned (even) and address[0] is ignored
    assign instruction = {mem[address], mem[address + 16'd1]};

endmodule