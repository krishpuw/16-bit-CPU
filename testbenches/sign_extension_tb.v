`timescale 1ns / 1ps

module sign_extension_tb();
reg [3:0] immd;
wire [15:0] sign_extend_imm;

sign_extension uut (
        .immd(immd),
        .sign_extend_imm(sign_extend_imm)
    );

initial begin

    immd = 4'b0100;
    #10;
    immd = 4'b0001; 
    #10;
    immd = 4'b1000;
    #10;
    immd = 4'b0101;
    #10;

    end
endmodule
