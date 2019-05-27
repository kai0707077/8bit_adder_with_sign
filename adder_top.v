`timescale 1ns / 1ps

module adder_top(

    input clk,
    input rst,
    input [3:0]btn,
    input [7:0]sw,

    output [3:0]sel,
    output [6:0]seg //
);


wire [3:0] outp;
wire load;
wire add_sub;
wire select;
wire [1:0] clks;
wire clk_prs;
wire [15:0] sel_out;
wire [3:0]x;
wire [20:0] final_result;
wire sign;


debounce M1(

    .clk(clk),
    .rst(rst),
    .inp(btn),
    
    .outp(outp)

);

state M2(

    .clk(clk),
    .reset(rst),
    .clk_prs(clk_prs),
    .btn_de(outp),

    .load(load),
    .add_sub(add_sub),
    .select(select)
);

clk_div M3(

    .clk(clk),
    .rst(rst),

    .clk_prs(clk_prs),
    .clks(clks)  //scan clock

);

count M4(

    .clk(clk),
    .clk_prs(clk_prs),
    .reset(rst),
    .outp(outp),
    .sw(sw),
    .select(select),
    .load(load),
    .add_sub(add_sub),

    .sel_out(sel_out),
    .sign(sign)
);

//*
/*add3 M5(

    .in(sel_out),
    .out(out)
);*/

//*
bin2bcd M6(

    .A(sel_out),
    
    .final_result(final_result)
);

scan M7(

    .clks(clks),
    .rst(rst),

    .sel(sel)

);

seg_mux M8(

    .result(final_result),
    .sel(sel),
    .rst(rst),
    .sign(sign),
	
    .x(x)
);

hex7seg M9(

    .x(x),
    
    .a_to_g(seg)
);

endmodule
