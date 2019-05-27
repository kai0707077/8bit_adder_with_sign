`timescale 1ns / 1ps
module seg_mux(
	
		input wire [20:0]result,
		input [3:0]sel,
		input rst,
		input sign,
	
		output reg [3:0]x
    );
	 
always@(sel)
	if(rst==1)
		x=0;
	else if(sign==1) begin
		case(sel)	 
       		4'b1110:x=result[3:0];
       		4'b1101:x=result[7:4];
       		4'b1011:x=result[11:8];
       		4'b0111:x=result[15:12];	 
	endcase
	end
	
	else if(sign==0) begin 
			case(sel)	 
       		4'b1110:x=result[3:0];
       		4'b1101:x=result[7:4];
       		4'b1011:x=result[11:8];
       		4'b0111:x=4'hA;
			endcase
	end


endmodule