//////////////////////////////////////////////////////////////////////////////////
// Class: ECE 176
// Team Members: Jose Maciel Torres, Subham Savita
// 
// Design Name: Control Unit
// Module Name: control
// Project Name: 13-bit RISC Processor
// Description: 
// 			Arithmetic logic unit that follows our custom 13-bit ISA
//
// Port List: 
//			input: Takes in the opcode and data from registers,
//			
//			output: 
//				ALUresult- calculated result
//				checkbranch- if this flag is true, then it is a branch instruction and PC 
//							loads the appropriate address for the next instruction
//				
//
//	STILL NOT WORKING AS INTENDED
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module ALU(
	input [3:0] opcode,
	input [12:0] i_dataA,i_dataB,
	output reg [12:0] o_result,
	output reg o_checkbranch);

	localparam NOP 		= 4'b0000;
	localparam ADD_ 	= 4'b0001;
	localparam SUB_ 	= 4'b0010;
	localparam MUL_ 	= 4'b0011;
	localparam DIV_ 	= 4'b0100;
	localparam AND_ 	= 4'b0101;
	localparam OR_ 		= 4'b0110;
	localparam XOR_ 	= 4'b0111;
	localparam J_ 		= 4'b1000;
	localparam ADDi_ 	= 4'b1001;
	localparam SUBi_	= 4'b1010;
	localparam LSL_		= 4'b1011;
	localparam BEQ_		= 4'b1100;
	localparam BGT_		= 4'b1101;
	localparam BLT_		= 4'b1110;
	localparam BNE_		= 4'b1111;

	always@(*) begin
		case(opcode)
			NOP:begin	
				o_result = 0; //NOP
			end
			ADD_:begin  
				o_result = i_dataA + i_dataB;
			end
			SUB_:begin  
				o_result = i_dataA - i_dataB;
			end
			MUL_:begin  
				o_result = i_dataA * i_dataB;
			end
			DIV_:begin  
				o_result = i_dataA / i_dataB;
			end
			AND_:begin  
				o_result = i_dataA & i_dataB;
			end
			OR_:begin  
				o_result = i_dataA | i_dataB;
			end
			XOR_:begin  
				o_result = i_dataA ^ i_dataB;
			end
			J_: begin
				o_checkbranch = 1;
			end
			ADDi_: begin
				o_result = i_dataA + i_dataB;
			end
			SUBi_: begin
				o_result = i_dataA - i_dataB;
			end
			LSL_:begin  
				o_result = i_dataA << i_dataB;
			end
			BEQ_: if(i_dataA == i_dataB) begin 
				o_checkbranch = 1;
			end
			BNE_: if(i_dataA != i_dataB)begin 
				o_checkbranch = 1;
			end
			BGT_: if(i_dataA > i_dataB)begin  
				o_checkbranch = 1;
			end
			BLT_: if(i_dataA < i_dataB)begin  
				o_checkbranch = 1;
			end
			default: begin 
				o_result = 0;
				o_checkbranch = 0;
			end
		endcase
	end
endmodule
