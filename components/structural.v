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


module structural(input clk);

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
    
    wire reg_write, mem_read, mem_write,reg_dest, zero,reset,regtomem;
    wire alu_src, mem_to_reg, aluop,branch,jump;
    wire [2:0] alu_control;
    wire [2:0] write_reg;
    
    assign pc_p2 = program_count +2;
    assign branch_a = pc_p2  + (sign_extend+2);
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
        .aluop(alu_op),
        .jump(jump)
    );
    
    register_file RF(
        .clk(clk),
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
        .a(mem_data),
        .b(alu_result),
        .select(mem_to_reg),
        .out(write_data)
    );
    
    // register file mux
    Multiplexer MX3(
        .a(instruction[8:6]),
        .b(instruction[5:3]),
        .select(reg_dest),
        .out(write_reg)
    );
    
    // branch  mux
    Multiplexer MX4(
        .a(pc_p2),
        .b(branch_a),
        .select(branch & zero),
        .out(mux5_input)
    );
    
    // jump  mux
    Multiplexer MX5(
        .a(mux5_input),
        .b(instruction[11:0] << 1),
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
        .address(alu_result),
        .writedata(read_data2),
        .memwrite(mem_write),
        .memread(mem_read),
        .readdata(mem_data)
    );
    
    
endmodule
