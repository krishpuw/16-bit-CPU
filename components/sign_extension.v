`timescale 1ns / 1ps

module sign_extension (

    input wire[3:0] immd,
    output wire[15:0] sign_extend_imm
);

    assign sign_extend_imm = {{12{immd[3]}}, immd};
    
endmodule