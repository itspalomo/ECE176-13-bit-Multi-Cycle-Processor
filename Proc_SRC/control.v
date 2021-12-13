//////////////////////////////////////////////////////////////////////////////////
// Class: ECE 176
// Team Members: Jose Maciel Torres, Subham Savita
// 
// Design Name: Control Unit
// Module Name: control
// Project Name: 13-bit RISC Processor
// Description: 
// This is what enables us to implement the 3 pipeline stages, Fetch, Decode, Execute
// 
// State machine for behavior of processor given a certain instruction. It will follow
// a different datapath. See datapath and state diagram.
//
// Port List: 
//			input: Takes in the loaded instruction,
//			
//			output: 
//				memWrite- Store the result of the ALU into memory
//				memRead- Read data from registers
//				PCop- Program counter op code, decides if PC+1 or Branch
//				PC- Current program counter points to the current instruction
//
//	opcode, addresses of the first and second  
// register as well as the destination register.
// 		Arithmetic			[opcode][rd][rs][rt]
//							[12:9][8:6][5:3][2:0]
//		Memory (ld,st,b,j)	[opcode][compare][offset]
//							[12:9][8:6][5:0]
//							[opcode][offset]
//							[12:9][8:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module control(
	input clk,reset,i_checkbranch,
	input [12:0] i_instruction,
	output reg [3:0] o_opcode,                      
	output reg [2:0] o_destination,o_addr1,o_addr2,     
	output reg [4:0] o_branch,                      
	output reg o_memWrite,o_memRead,o_PCop,o_PC);         

	localparam RESET_STATE = 0;
	localparam FETCH = 1;
	localparam DECODE = 2;
	localparam MATH_EXECUTE = 3;
	localparam BRANCH_EXECUTE = 4;

	reg [2:0] state;

	always@(posedge clk) begin
		if(reset == 1'b1) state <= 0;
		case(state)
			RESET_STATE: begin 
				if(i_instruction[12:9] == 4'b0000) begin
				o_PCop <= 0;
				o_PC <= 0;
				state <= FETCH;
				end
				else    o_PC <= ~o_PC;
			end
			FETCH: begin                    
				o_opcode      <= 0;
				o_addr1       <= 0;
				o_addr2       <= 0;
				o_destination <= 0;
				o_branch      <= 0;
				o_memWrite    <= 0;
				o_memRead     <= 0;
				o_PCop      <= 0;
				state         <= DECODE;
			end
			DECODE: begin                    
				if(i_instruction[12:9] == 4'b1000) begin
					o_opcode      <= i_instruction[12:9];          
					o_addr1       <= 0;           
					o_addr2       <= 0;            
					o_branch      <= i_instruction[8:0];            
					o_destination <= 0;                    
					o_memRead     <= 1;
					o_PC 	      <= 0;
					state         <= BRANCH_EXECUTE;           
				end
				else if(i_instruction[12:11] == 2'b11) begin
					o_opcode      <= i_instruction[12:9];          
					o_addr1       <= i_instruction[8:6];           
					o_addr2       <= i_instruction[5:3];            
					o_branch      <= i_instruction[2:0];            
					o_destination <= 0;                    
					o_memRead     <= 1;
					state         <= BRANCH_EXECUTE;           
				end
				else begin
					o_opcode      <= i_instruction[12:9];          
					o_destination <= i_instruction[8:6];           				
					o_addr1       <= i_instruction[5:3];            
					o_addr2       <= i_instruction[2:0];            
					o_memRead     <= 1;
					o_branch      <= 0; 
					state 		<= MATH_EXECUTE;                    
				end
			end

			//s3, memwrite enables ALUresult to be written to memory. 

			MATH_EXECUTE: begin                
				o_memWrite    <= 1;                      
				o_memRead     <= 0;
				o_PCop      <= 0;                       
				state         <= FETCH;                     
			end
			BRANCH_EXECUTE: begin                
				o_memRead     <= 0; 
				o_PCop      <= i_checkbranch;               
				state         <= FETCH;         
			end
			default: state <= 0;
		endcase
	end
endmodule
