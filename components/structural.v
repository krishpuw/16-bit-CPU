`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2026 02:34:06 PM
// Design Name: 
// Module Name: structural
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


module structural(input clk, input reset,output [15:0] LED);

    wire [15:0] program_count;
    wire [15:0] instruction;
    wire [15:0] read_data1;
    wire [15:0] read_data2;
    wire [15:0] alu_result;
    wire [15:0] write_data;
    wire [15:0] sign_extend;
    wire [15:0] alu;
    wire [15:0] mux5_input;
    wire [15:0] program_counter_input;
    wire [15:0] mem_data;
    wire [15:0] read_data;
    wire [15:0] pc_p2;
    wire [15:0] branch_a;
    wire [2:0] funct;
    wire reg_write, mem_read, mem_write,reg_dest, zero,regtomem;
    wire alu_src, mem_to_reg,branch,jump,bne;
    wire [2:0] alu_control;
    wire [3:0] write_reg;
    wire [1:0] aluop;
    wire [15:0] pc_2;
    
    reg [25:0] clock_divisor;
    always @(posedge clk or posedge reset) begin
        if (reset)begin
         clock_divisor <= 0;
        end
        else begin
            clock_divisor <= clock_divisor + 1;
        end
    end

    wire slow = clock_divisor[25];
    reg [15:0] led_lit;
    always @(posedge slow or posedge reset) begin
        if (reset)begin
            led_lit <= 0;
        end
        else begin
            led_lit <= alu_result;
        end
    end
    assign LED = led_lit;
    
    assign pc_p2 = program_count;
    assign branch_a = pc_p2  + (sign_extend << 1);
    assign write_reg = instruction[11:8];
    
    pc PC(
        .clk(clk),
        .outputpc(program_count),
        .reset(reset),
        .inputpc(program_counter_input)
    );
    
    instruction_memory IM(
        .instruction(instruction),
        .address(program_count)
    );
    
    control_unit CU(
        .opcode(instruction[15:12]),
        .regdst(reg_dest),
        .alusrc(alu_src),
        .Memtoreg(mem_to_reg),
        .memwrite(mem_write),
        .regwrite(reg_write),
        .memread(mem_read),
        .branch(branch),
        .aluop(aluop),
        .jump(jump),
        .func(instruction[2:0])
    );
    
    register_file RF(
        .clk(clk),
        .reset(reset),
        .read_reg1(instruction[7:4]),
        .read_data1(read_data1),
        .read_reg2(instruction[11:8]),
        .read_data2(read_data2),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write)
    );
    
    sign_extension SE(
        .immd(instruction[3:0]),
        .sign_extend_imm(sign_extend)
    );
    
    //alu mux
    Multiplexer MX1(
        .a(read_data2),
        .b(sign_extend),
        .select(alu_src),
        .out(alu)
    );
    
    // data mem mux
    Multiplexer MX2(
        .a(alu_result),
        .b(mem_data),
        .select(mem_to_reg),
        .out(write_data)
    );
    
    // register file mux
    //Multiplexer MX3(
    //    .a(instruction[8:6]),
    //    .b(instruction[5:3]),
    //    .select(reg_dest),
    //    .out(write_reg)
    //);
    
    // branch  mux
    Multiplexer MX4(
        .a(pc_p2),
        .b(branch_a),
        .select((branch & zero) | (bne & ~zero)),
        .out(mux5_input)
    );
    
    // jump  mux
    Multiplexer MX5(
        .a(mux5_input),
        .b(pc_p2 + {{3{instruction[11]}}, instruction[11:0], 1'b0}),
        .select(jump),
        .out(program_counter_input)
    );
    
    ALU AU(
        .a(read_data1),
        .b(alu),
        .alu_control(alu_control),
        .zero(zero),
        .result(alu_result)
    );
    
    data_memory DM(
        .clk(clk),
        .address(alu_result),
        .writedata(read_data2),
        .memwrite(mem_write),
        .memread(mem_read),
        .readdata(mem_data)
    );
    
    alu_control ALUCTL (
    .aluop(aluop),
    .funct(instruction[2:0]),
    .alu_control(alu_control)
);
endmodule
