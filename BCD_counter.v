module BCD_counter(clk,clear,enable,out0,out1,out2); //works
	input clk,clear,enable;
	output reg [3:0] out0,out1,out2;
	
	always @(posedge clk) begin
		if(clear) begin
			out0 <= 0;
			out1 <= 0;
			out2 <= 0;
		end else if(enable) begin
			if(out0 == 4'b1001) begin
				out0 <= 0;
				if(out1 == 4'b1001) begin
					out1 <= 0;
					if(out2 == 4'b1001) begin
						out2 <= 0;
					end else begin
						out2 <= out2 + 1;
					end
				end else begin
					out1 <= out1 + 1;
				end
			end else begin
				out0 <= out0 + 1;
			end
		end
	end
endmodule
