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
module instruction_memory(
	input reset,
	input [5:0] i_PCcurr,
	output [12:0] o_instruction);

	reg [12:0] o_instruction_memory [63:0]; 

	always@(*) if(reset == 1'b1) $readmemb("o_instruction.txt",o_instruction_memory);

	assign o_instruction = o_instruction_memory[i_PCcurr];
endmodule