`timescale 1ns / 1ps

module test_adder;

reg [3:0] a;
reg [3:0] b;

wire carry;
wire [3:0] sum;

fourbit_adder uut (
    .a(a),
    .b(b),
    .carry(carry),
    .sum(sum)
    );
    
initial begin
    a = 4'b0000; b = 4'b0000;
    #10;

    a = 4'b0011; b = 4'b0101;
    #10;

    a = 4'b1111; b = 4'b0001;
    #10;

    $stop;
end

endmodule