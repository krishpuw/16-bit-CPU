`timescale 1ns / 1ps
module control_unit (

    input wire[3:0] opcode,
    input wire[2:0] func,
    output reg regdst,
    output reg alusrc,
    output reg Memtoreg,
    output reg regtomem,
    output reg memwrite,
    output reg regwrite,
    output reg memread,
    output reg branch,
    output reg [1:0] aluop,
    output reg jump, 
    output reg bne   
);
    
always @(*) begin
    regdst = 1'b0;
    alusrc = 1'b0;
    Memtoreg = 1'b0;
    regtomem = 1'b0;
    memwrite = 1'b0;
    regwrite = 1'b0;
    memread = 1'b0; 
    branch = 1'b0; 
    aluop = 2'b00;
    jump = 1'b0;
    
    case (opcode)
        
        // R type
        4'b0000: begin
            regdst = 1'b1;
            alusrc = 1'b0;
            Memtoreg = 1'b0;
            regtomem = 1'b0;
            memwrite = 1'b0;
            regwrite = 1'b1;
            memread = 1'b0; 
            branch = 1'b0; 
            aluop = 2'b10;
            jump = 1'b0;
            bne = 1'b0;
            
        end 

        // lw
        4'b0001: begin
            regdst = 1'b0;
            alusrc = 1'b1;
            Memtoreg = 1'b1;
            regtomem = 1'b0;
            memwrite = 1'b0;
            regwrite = 1'b1;
            memread = 1'b1; 
            branch = 1'b0; 
            aluop = 2'b00;
            jump = 1'b0;
            bne = 1'b0;
            
        end   
        //sw
         4'b0010: begin
            regdst = 1'b0;
            alusrc = 1'b1;
            Memtoreg = 1'b0;
            regtomem = 1'b1;
            memwrite = 1'b1;
            regwrite = 1'b0;
            memread = 1'b0; 
            branch = 1'b0; 
            aluop = 2'b00;
            jump = 1'b0;
            bne = 1'b0;
            
        end   

        // addi
         4'b0011: begin
            regdst = 1'b0;
            alusrc = 1'b1;
            Memtoreg = 1'b0;
            regtomem = 1'b0;
            memwrite = 1'b0;
            regwrite = 1'b1;
            memread = 1'b0; 
            branch = 1'b0; 
            aluop = 2'b00;
            jump = 1'b0;
            bne = 1'b0;
            
        end   
        //beq
         4'b0100: begin
            regdst = 1'b0;
            alusrc = 1'b0;
            Memtoreg = 1'b0;
            regtomem = 1'b0;
            memwrite = 1'b0;
            regwrite = 1'b0;
            memread = 1'b0; 
            branch = 1'b1;
            bne = 1'b0;
            // need to check for aluop 
            aluop = 2'b01;
            jump = 1'b0;
            
        end   
        // bne 
         4'b0101: begin
            regdst = 1'b0;
            alusrc = 1'b0;
            Memtoreg = 1'b0;
            regtomem = 1'b0;
            memwrite = 1'b0;
            regwrite = 1'b0;
            memread = 1'b0; 
            branch = 1'b1; 
            bne = 1'b1;
            // aluop possoibly
            aluop = 2'b01;
            jump = 1'b0;
         end  
            // jump 
         4'b0110: begin
            regdst = 1'b0;
            alusrc = 1'b0;
            Memtoreg = 1'b0;
            regtomem = 1'b0;
            memwrite = 1'b0;
            regwrite = 1'b0;
            memread = 1'b0; 
            branch = 1'b0; 
            // aluop possoibly
            aluop = 2'b01;
            jump = 1'b1;
            bne = 1'b0;
        end  
        default: begin
        regdst = 1'b0;
        alusrc = 1'b0;
        Memtoreg = 1'b0;
        regtomem = 1'b0;
        memwrite = 1'b0;
        regwrite = 1'b0;
        memread = 1'b0; 
        branch = 1'b0; 
        aluop = 2'b00;
        jump = 1'b0;
        bne = 1'b0;
    end
    endcase
    
end

endmodule