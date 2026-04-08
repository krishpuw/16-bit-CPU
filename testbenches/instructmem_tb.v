`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 09:43:26 PM
// Design Name: 
// Module Name: instructmem_tb
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


module instructmem_tb;

    reg  [15:0] address;
    wire [15:0] instruction;

    instruction_memory uut (
        .address     (address),
        .instruction (instruction)
    );

    initial begin
        $monitor("time=%0t | address=%0d (0x%h) | instruction=0x%h",
                  $time, address, address, instruction);

        address = 16'd0; #10;
        
        address = 16'd2; #10;
        
        address = 16'd4; #10;
      
        address = 16'd6; #10;
       
        address = 16'd14; #10;
        
        address = 16'd16; #10;
        
        address = 16'd18; #10;
        
        address = 16'd30; #10;
        $finish;
        end
             
endmodule
