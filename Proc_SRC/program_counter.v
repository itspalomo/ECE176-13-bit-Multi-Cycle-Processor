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
`timescale 1ns/100ps


module PC(
	input clk,reset,i_PCop,
	input [12:0]i_PC,
	input [8:0] i_Branch,
	output reg [12:0] o_PCcurr );

	reg [12:0]PCprev;

	always@(posedge clk) begin
		if(reset == 1'b1)begin
			 o_PCcurr <= 13'b0000_000_000_000;
			 #2 PCprev <= o_PCcurr;
		end
		else if((i_PCop == 13'b0000_000_000_000) && (reset == 1'b0))begin
			o_PCcurr <= PCprev + 13'b0000_000_000_001;
			#2 PCprev <= o_PCcurr;
		end
		else o_PCcurr <= i_PC + i_Branch;
		
	end			
endmodule
