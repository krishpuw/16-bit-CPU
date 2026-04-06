`timescale 1ns / 1ps

module structural_tb;
    reg clk;
    reg reset;

    
    structural DUT(
        .clk(clk),
        .reset(reset)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    
    initial begin
        reset = 1;
        #10;
        reset = 0;
        #200; 
        $finish;
    end

   
    initial begin
        $display("Time | PC | instr | r1 | r2 | alu_in2 | ALU_result | write_data | reg_write | sign_extend | mux_alu | mux_mem | zero");
        $monitor("%0t | %d | %b | %d | %d | %d | %d | %d | %b | %d | %d | %d | %b",
                 $time,
                 DUT.program_count,
                 DUT.instruction,
                 DUT.read_data1,
                 DUT.read_data2,
                 DUT.alu,             
                 DUT.alu_result,
                 DUT.write_data,
                 DUT.reg_write,
                 DUT.sign_extend,
                 DUT.alu,             
                 DUT.write_data,      
                 DUT.zero
                 );
    end
endmodule