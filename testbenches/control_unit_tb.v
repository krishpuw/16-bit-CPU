`timescale 1ns / 1ps

module control_unit_tb();

    reg [3:0] opcode;
    reg [2:0] func;
    wire regdst;
    wire alusrc;
    wire Memtoreg;
    wire regtomem;
    wire memwrite;
    wire regwrite;
    wire memread;
    wire branch;
    wire [1:0] aluop;
    wire jump;
    wire bne;


    control_unit uut (
        .opcode(opcode),
        .func(func),
        .regdst(regdst),
        .alusrc(alusrc),
        .Memtoreg(Memtoreg),
        .regtomem(regtomem),
        .memwrite(memwrite),
        .regwrite(regwrite),
        .memread(memread),
        .branch(branch),
        .aluop(aluop),
        .jump(jump),
        .bne(bne)
    );

    initial begin
    // r type
        opcode = 4'b0000;  
        func = 3'b000;
        #10;
        //lw
        opcode = 4'b0001;  
        #10;
        //sw
        opcode = 4'b0010;  
        #10;
        //addi
        opcode = 4'b0011;  
        #10;
        //beq
        opcode = 4'b0100;  
        #10;
        //bne
        opcode = 4'b0101;  
        #10;
        //jump
        opcode = 4'b0110;  
        #10;
        //default
//        opcode = 4'b0111;  just 0 everything
        #10;
        
    end

endmodule
