//////////////////////////////////////////////////////////////////////////////////
// Class: ECE 176
// Team Members: Jose Maciel Torres, Subham Savita
// 
// Design Name: Instruction Memory
// Module Name: instruction_memory
// Project Name: 13-bit RISC Processor
// Description: 
// 			This is the instruction memory for our program. Supports a program size of
//			64 instructions due to the branch limitations
//				
// Port List: 
//			input: reset, Current PC- address of the instruction to be loaded
//			
//			output: 
//				Instruction - loaded instruction from given address
//	
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

module instruction_memory(
	input reset,
	input [12:0] i_PCcurr,
	output [12:0] o_instruction);

	reg [12:0] o_instruction_memory [511:0]; 

	always@(*)begin
		 if(reset == 1'b1) $readmemb("sample_instructions.txt",o_instruction_memory);
		 if(i_PCcurr[12:9] > 4'b0000) $display("Program Counter overflow!");
	end
	
	assign o_instruction = o_instruction_memory[i_PCcurr[8:0]];
endmodule