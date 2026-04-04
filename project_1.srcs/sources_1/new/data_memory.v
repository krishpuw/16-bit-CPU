`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2026 08:30:11 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input [16:0] address,
    input [16:0] writedata,
    input memwrite,
    input memread,
    output reg [16:0] readdata
    );
    
    reg [7:0] memory [0:255];
always@(address,writedata,memwrite,memread,readdata) 
begin
    if(memwrite) begin
        memory[address]     <= writedata[15:8]; 
        memory[address + 1] <= writedata[7:0];
    end
    
    if (memread) begin
        readdata = {memory[address], memory[address + 1]};
    end else begin
        readdata = 16'b0;
    end
    
end

endmodule
