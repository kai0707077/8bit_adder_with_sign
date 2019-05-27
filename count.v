`timescale 1ns / 1ps

module count(

    input clk,
    input clk_prs,
    input reset,
    input [3:0] outp,
    input [7:0] sw,
    input select,
    input load,
    input add_sub,

    output reg [15:0] sel_out,
    output reg sign
);

reg [7:0] number_1;
reg [15:0] result;

//A loadable 8-bit register
always@(posedge clk_prs or posedge reset)
 begin
   if(reset)
        number_1 <= 8'd0;
         
   else if (load)
        number_1 <= sw[7:0];
            
 end
	
// The calculator
always@(*)
    begin
    if  (add_sub)begin
        result <= number_1 + sw;
		  sign <= 1'b1;
	 end
    else if(add_sub==0&&number_1>=sw)begin
        result <= number_1 - sw;
		  sign <= 1'b1;
	 end
	 else if(add_sub==0&&number_1<sw)begin
		  result <=8'd00065536-number_1+sw;
		  sign <= 1'b0;
	 end
    end

//Mux output  
always@(*)
	begin
		if (select)
			sel_out=result;
		else
			sel_out=sw;
	end
	 
endmodule
