`timescale 1ns / 1ps

module scan(

    input wire [1:0]clks,
    input wire rst,
	 //input [23:0]count,
	 
    output reg [3:0]sel	
);


 always@(clks[1:0])begin
	if(rst)
		sel=4'b0000;
	else
     case(clks)
       
       2'b00:sel = 4'b1110; // Enable U1 ---first led of 7seg
       2'b01:sel = 4'b1101; // Enable U2 --second led of 7seg
       2'b10:sel = 4'b1011; // Enable U3 ---third led of 7seg
       2'b11:sel = 4'b0111; // Enable U4 -----4th led of 7seg 
     endcase
  end 
endmodule
