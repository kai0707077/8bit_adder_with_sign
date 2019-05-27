`timescale 1ns / 1ps

module state(

    input clk,
    input reset,
	input clk_prs, // for deteced btn
	input [3:0] btn_de,
	//input [7:0] sw_de,
	
	output reg load,
	output reg add_sub,
	output reg select //
    //output state

);

//assign reset=btn_de[0];

reg [2:0] state;
reg [2:0] next;

//reg load;    //for register
//reg add_sub; //for add or minus
//reg select;  //for display sum

parameter [2:0]IDLE     = 3'b000, 
               LOAD_ADD = 3'b001,
               LOAD_SUB = 3'b010,
               WAIT1    = 3'b011,
			   WAIT2    = 3'b100,
			   ADD_RESL	= 3'b101,
			   SUB_RESL	= 3'b110;

    
always @(posedge clk_prs or posedge reset)
    if (reset)
        state <= IDLE;
    else
        state <= next;

always @(*)
    begin
        //next = IDLE;
        load = 1'b0;
        add_sub = 1'b1;
		select=1'b0;
		  
    case (state)
		IDLE :
			begin
			 if (btn_de[1])
				  next = LOAD_ADD;
			 else if (btn_de[2])
					next = LOAD_SUB;
			 else
				  next = IDLE;
			end
		LOAD_ADD :
			 begin
				  load = 1'b1;
				  next = WAIT1;
			 end
		LOAD_SUB :
			 begin
				  load = 1'b1;
				  next = WAIT2;
			 end
		WAIT1:
			 begin
				 if (btn_de[3])
				  next = ADD_RESL;
				 else
				  next = WAIT1;
			 end
		WAIT2:
			 begin
				 if (btn_de[3])
				  next = SUB_RESL;
				 else
				  next = WAIT2;
			 end
			 
		ADD_RESL:
			begin
				select=1'b1;
				add_sub=1'b1;
				if (btn_de[0])
				  next = IDLE;
				 else
				  next = ADD_RESL;
			end
			
		SUB_RESL:
			begin
				select=1'b1;
				add_sub=1'b0;
				if (btn_de[0])
				  next = IDLE;
				 else
				  next = SUB_RESL;
			end
		default:
			begin
				next = IDLE;
			end
			
			
		endcase
end

endmodule
