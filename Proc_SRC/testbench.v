// testbench for risc processor
`timescale 1ns/100ps

module riscproc_tb;

 reg clk;
 reg reset;

 top_risc_proc uut (
  .clk(clk),
  .reset(reset)
 );

 initial 
  begin
   clk <=0; 
   reset=1;
   #200;
   $finish;
  end

 always #5 clk = ~clk;

endmodule