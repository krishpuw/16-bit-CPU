module tb_structural;

    reg clk;
    reg reset;

    structural uut (
        .clk(clk),
        .reset(reset)
    );
    wire [15:0] pc    = uut.program_count;
    wire [15:0] instruct = uut.instruction;

    wire [15:0] r0 = uut.RF.registers[0];
    wire [15:0] r1 = uut.RF.registers[1];
    wire [15:0] r2 = uut.RF.registers[2];
    wire [15:0] r3 = uut.RF.registers[3];
    wire [15:0] r4 = uut.RF.registers[4];
    wire [15:0] r5 = uut.RF.registers[5];
    wire [15:0] r6 = uut.RF.registers[6];
    wire [15:0] r7 = uut.RF.registers[7];

    wire [2:0]  alu_control = uut.alu_control;
    wire [15:0] mem0 = {uut.DM.memory[0], uut.DM.memory[1]};


    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
 
        reset = 1'b1;
        force uut.alu_control = 3'b000;
        @(posedge clk); #1;
        reset = 1'b0;

        force uut.alu_control = 3'b000;
        // addi r1,r0,5
        @(posedge clk); #1;
    
        // addi r2,r0,6
        @(posedge clk); #1;
 
        // addi ,r3,r0,3
        @(posedge clk); #1;

        // add r0,r3,r2
        force uut.alu_control = 3'b000;
        @(posedge clk); #1;
    
        // sub
        force uut.alu_control = 3'b001;
        @(posedge clk); #1;;
 
        // and
        force uut.alu_control = 3'b011;
        @(posedge clk); #1;
       
 
        // sll
        force uut.alu_control = 3'b010;
        @(posedge clk); #1;
 
        //sw
        force uut.alu_control = 3'b000;
        @(posedge clk); #1;
 
        //lw
        force uut.alu_control = 3'b000;
        @(posedge clk); #1;
    
        //beq
        force uut.alu_control = 3'b001;
        @(posedge clk); #1; 
 
        //not taken
        force uut.alu_control = 3'b000;  
        @(posedge clk); #1;             

        // bne
        force uut.alu_control = 3'b001;
        @(posedge clk); #1; 

        //not taken
        uut.alu_control = 3'b000;
        @(posedge clk); #1; 
    
        //jump
        uut.alu_control = 3'b000;
        @(posedge clk); #1;    

        release uut.alu_control = 3'b000;

    $stop;        

    end
 
endmodule