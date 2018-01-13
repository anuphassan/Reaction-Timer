module LSRF (clk,reset,random,downcount); //should be LFSR I know, but there was a typo when I created the file, so I kept it
	//32 bit linear feedback shift register
	parameter n = 12;
	input clk,reset;
	output reg [n-1:0]random;
	output reg downcount = 0;
	
	always @(posedge clk) begin
		if(!reset) begin
			random = 37;
		end else begin
			random[n-1:1] <= random[n-2:0];
			random[0] <= random[n-1] ^ random[n-2];
		end
	end
endmodule
