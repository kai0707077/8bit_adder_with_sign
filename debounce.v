`timescale 1ns / 1ps

module debounce(
    input wire [3:0] inp,
    input wire clk,
    input wire rst,
    output wire [3:0] outp
    );
	 
	 reg [3:0] delay1;
	 reg [3:0] delay2;
	 reg [3:0] delay3;
	 
	 //assign reset=btn_de[0];
	 
	 always @(posedge clk or posedge rst )
	 begin
			if (rst == 1)
				begin 
					delay1 <= 4'b0000;
					delay2 <= 4'b0000;
					delay3 <= 4'b0000;
				end
			else
				begin
					delay1 <= inp;
					delay2 <= delay1;
					delay3 <= delay2;
				end
	 end
		
	 assign outp = delay1 & delay2 & delay3;


endmodule
