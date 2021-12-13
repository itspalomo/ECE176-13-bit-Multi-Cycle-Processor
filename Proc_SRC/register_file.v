//////////////////////////////////////////////////////////////////////////////////
// Class: ECE 176
// Team Members: Jose Maciel Torres, Subham Savita
// 
// Design Name: Register File
// Module Name: register_file
// Project Name: 13-bit RISC Processor
// Description: 
// 			Holds the address of all the registers: r0-r6
//				
// Port List: 
//			input: clock, reset bit, 
//				memwrite- enables writing ALUresult to memory
//				memread- enables reading data from registers
//				i_address1,i_address2,i_destReg- register addresses for rs rd and rt
//				i_ALUresult- arithmetic result
//			
//			output: 
//				dataA,dataB - value within registers 
//				
//	
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module register_file(
	input clk,reset,i_memWrite,i_memRead,
	input [2:0] i_address1,i_address2,i_destReg,
	input [12:0] i_ALUresult,
	output reg [12:0] o_dataA, o_dataB);

	reg [12:0] memory [7:0];
	reg [4:0] i ; 

	initial begin 
		for (i = 0; i < 7; i = i + 1) 
		 memory[i] = 13'b0000_000_000_000; // registers initialized to 0
	end	

	always@(posedge clk) begin
	if(reset == 1'b1) begin //reset all values
		memory[0] <= 0;
		memory[1] <= 0;
		memory[2] <= 0;
		memory[3] <= 0;
		memory[4] <= 0;
		memory[5] <= 0;
		memory[6] <= 0;
	end
	else if(i_memWrite == 1'b1) begin //Writing data to memory is enabled
		memory[i_destReg] <= i_ALUresult;
	end
	else if(i_memRead == 1'b1) begin //read data from register is the i_memRead is enabled
		o_dataA <= memory[i_address1];
		o_dataB <= memory[i_address2];
	end
	else begin
	o_dataA <= 0;
	o_dataB <= 0;
	end
	end
endmodule
