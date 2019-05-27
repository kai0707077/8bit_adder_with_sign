`timescale 1ns / 1ps

module clk_div(
    input clk,
    input rst,
    output [1:0] clks,
    output clk_prs //

   
);

 reg [29:0]div;

always@ (posedge clk or posedge rst)
    begin
        if(rst)
            div <= 30'b0;
        else
            div <= div + 1;
							
    end

//---for real--------------------------------------

assign clks[1:0] = div[19:18];
assign clk_prs = div[19];

//---for test bench--------------------------------

//assign clk_prs = div[0];   
//assign clks[1:0] = div[2:1];
			
 

endmodule