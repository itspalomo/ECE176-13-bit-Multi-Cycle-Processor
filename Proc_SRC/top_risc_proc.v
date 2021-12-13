//////////////////////////////////////////////////////////////////////////////////
// Class: ECE 176
// Team Members: Jose Maciel Torres, Subham Savita
// 
// Design Name: Top Level Design File
// Module Name: top_risc_proc
// Project Name: 13-bit RISC Processor
// Description: 
// 				
// Port List: 
//			
//	
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "ALU.v"
`include "program_counter.v"
`include "control.v"
`include "instruction_memory.v"
`include "register_file.v"

module top_risc_proc(clk,reset);
	input clk,reset;
	wire w_memWrite,w_memRead,w_PCop,w_PC,w_checkbranch;
	wire [12:0] w_instruction,w_ALUresult,w_dataA,w_dataB;
	wire [5:0] w_PCcurr,w_branch;
	wire [3:0] w_opcode;
	wire [2:0] w_regDest,w_regAddress1,w_regAddress2;
	
	

	PC u0(
	.clk(clk),
	.reset(reset),
	.i_PCop(w_PCop),
	.i_PC(w_PC),
	.i_Branch(w_branch),
	.o_PCcurr(w_PCcurr) 
	);

	instruction_memory u1(
	 .reset(reset),
	 .i_PCcurr(w_PCcurr),
	 .o_instruction(w_instruction)
	);

	ALU u2(
	 .opcode(w_opcode),
	 .i_dataA(w_dataA),
	 .i_dataB(w_dataB),
	 .o_result(w_ALUresult),
	 .o_checkbranch(w_checkbranch)
	 );

	register_file u3(
	 .clk(clk),
	 .reset(reset),
	 .i_memWrite(w_memWrite),
	 .i_memRead(w_memRead),
	 .i_address1(w_regAddress1),
	 .i_address2(w_regAddress2),
	 .i_destReg(w_regDest),
	 .i_ALUresult(w_ALUresult),
	 .o_dataA(w_dataA), 
	 .o_dataB(w_dataB)
	 );


	control u4(
	 .clk(clk),
	 .reset(reset),
	 .i_checkbranch(w_checkbranch),
	 .i_instruction(w_instruction),
	 .o_opcode(w_opcode),                      
	 .o_destination(w_regDest),
	 .o_addr1(w_regAddress1),
	 .o_addr2(w_regAddress2),     
	 .o_branch(w_branch),                      
	 .o_memWrite(w_memWrite),
	 .o_memRead(w_memRead),
	 .o_PCop(w_PCop),
	 .o_PC(w_PC)
	 ); 


endmodule
