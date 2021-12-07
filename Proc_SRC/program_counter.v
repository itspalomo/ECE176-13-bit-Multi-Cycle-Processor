//////////////////////////////////////////////////////////////////////////////////
// Class: ECE 176
// Team Members: Jose Maciel Torres, Subham Savita
// 
// Design Name: Program Counter
// Module Name: PC
// Project Name: 13-bit RISC Processor
// Description: 
// 			Program counter for our custom 13-bit ISA
//			
//			Note: Branchable address are 6 bit wide or 2^6 for a total of 64 supported instructions in memory
//				
// Port List: 
//			input: clock, reset, PC Opcode decided PC+1 or Branch, Program Counter before increment
//			
//			output: 
//				PCcurr - calculated input given PCop
//	
//////////////////////////////////////////////////////////////////////////////////
module PC(
	input clk,reset,i_PCop,i_PC,
	input [5:0] i_Branch,
	output reg [12:0] o_PCcurr );

	always@(posedge clk) begin
		if(reset == 1'b1) o_PCcurr <= 12'b0000_000_000_000;
		if(i_PC == 1'b1) begin
			if(i_PCop == 1'b0) o_PCcurr <= o_PCcurr + 1;
			else o_PCcurr <= i_Branch;
		end
	end			
endmodule
