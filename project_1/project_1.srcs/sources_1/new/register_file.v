`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 12:32:06 AM
// Design Name: 
// Module Name: register_file
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

module register_file (
    input  wire        clk,
    input  wire        reset,

    // read 1 - rs field [7:4]
    input  wire [3:0]  read_reg1,    // register the index to read
    output wire [15:0] read_data1,   // data read from rs

    // read 2  - rt or rd field [11:8]
    input  wire [3:0]  read_reg2,    // same as above
    output wire [15:0] read_data2,   // same as above

    // write
    input  wire [3:0]  write_reg,    // reg index to write to
    input  wire [15:0] write_data,   // the data to write
    input  wire        reg_write     // write enable activ-high
);

    // 16 registers, each 16 bits wide
    reg [15:0] registers [0:15];
    integer i;

    // synchronous write / reset
    always @(posedge clk) begin
        if (reset) begin
            // zero out all of the reg on reset
            for (i = 0; i < 16; i = i + 1)
                registers[i] <= 16'b0;
        // otherwise start write the data
        end else if (reg_write) begin
            registers[write_reg] <= write_data;
        end
    end

    // async read perchance
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

endmodule