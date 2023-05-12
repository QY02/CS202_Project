`timescale 1ns / 1ps

module IFetc32(Instruction, branch_base_addr, link_addr, clk, rst_n, Addr_result, Read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero
,upg_rst_i,upg_clk_i,upg_wen_i,upg_adr_i,upg_dat_i,upg_done_i);
    // output reg [31:0] Instruction_test;
    output[31:0] Instruction; // the instruction fetched from this module to Decoder and Controller
    output[31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction
    output[31:0] link_addr; // (pc+4) to Decoder which is used by jal instruction
    //from CPU TOP
    input clk, rst_n; // Clock and rst_n
    // from ALU
    input[31:0] Addr_result; // the calculated address from ALU
    input Zero; // while Zero is 1, it means the ALUresult is zero
    // from Decoder
    input[31:0] Read_data_1; // the address of instruction used by jr instruction
    // from Controller
    input Branch; // while Branch is 1,it means current instruction is beq
    input nBranch; // while nBranch is 1,it means current instruction is bnq
    input Jmp; // while Jmp 1, it means current instruction is jump
    input Jal; // while Jal is 1, it means current instruction is jal
    input Jr; // while Jr is 1, it means current instruction is j

    input upg_rst_i; // UPG reset (Active High)
    input upg_clk_i; // UPG clock (10MHz)
    input upg_wen_i; // UPG write enable
    input[13:0] upg_adr_i; // UPG write address
    input[31:0] upg_dat_i; // UPG write data
    input upg_done_i ;// 1 if program finished

    reg[31:0] PC, Next_PC;
    wire kickOff = upg_rst_i | (~upg_rst_i & upg_done_i);
    prgrom prgrom(
        .clka(kickOff?clk:upg_clk_i),
        .wea(kickOff?1'b0:upg_wen_i),
        .addra(kickOff?PC[15:2]:upg_adr_i),
        .dina(kickOff?32'h00000000:upg_dat_i),
        .douta(Instruction)
    );

    assign branch_base_addr = PC + 32'd4; // pc+4
    assign link_addr = PC + 32'd4; // pc+4

    always @(*) begin
        if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne
            Next_PC = Addr_result; // the calculated new value for PC
        else if(Jr == 1)
            Next_PC = Read_data_1; // the value of $31 register
        else
            Next_PC = PC + 32'd4; // PC+4
    end

    always @(negedge clk, negedge rst_n) begin
        if(~rst_n) begin
            PC <= 32'h0000_0000;
            // Instruction_test <= 32'hffffffff;
        end
        else begin
            // if (PC == 32'd16) begin
            //     Instruction_test <= Instruction;
            // end
            // else begin
            //     Instruction_test <= Instruction_test;
            // end
            if((Jmp == 1) || (Jal == 1)) begin
                PC <= {PC[31:28], Instruction[25:0], 2'b00};
            end
            else
                PC <= Next_PC;
        end
    end

endmodule
