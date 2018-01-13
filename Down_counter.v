module Down_counter(random,reset,enable,clk,outLed,Q); //works
	input [11:0] random;
	input clk,enable,reset;
	output reg [11:0] Q;
	output reg outLed = 0;
	
	always @(posedge clk) begin 
		if(enable == 0) begin
			Q <= random;
		end else if(enable == 1) begin
			if(Q > 0)
				Q <= Q - 1;
		end
	end
	
	always @(*) begin
		outLed = (Q == 0);
	end
endmodule
