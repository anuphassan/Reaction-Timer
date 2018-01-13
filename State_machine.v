module stateMachine(clk,react,reset,downcount,score,high_score,out,led); 
							//does not work, goes to 1 state at reset, stays there for react, and goes to 0 when both hit
	input react;
	input reset;
	input clk;
	input downcount;
	input [11:0]score;
	output reg [4:0]out;
	output reg led = 0;
	reg [2:0] state;
	reg [2:0] nextState;
	output reg [11:0] high_score = 12'b100110011001;
	reg start,stop;
	parameter idle=0,random=1,reaction=2,done=3;
	
	always @(state) begin
		case(state)
			idle:out = 4'b0001; //idle set bcd counter to 0
			random:out = 4'b0010; //downcounter enable
			reaction:out = 4'b0100; //bcd counter enable
			done:out = 4'b1000; //done intermediate state
			default:out = 4'b0001;
		endcase
	end
	
	always @(posedge clk) begin
		state <= nextState;
	end
	
	always @(negedge react, negedge reset, posedge downcount) begin
		case(state)
			idle:
				if(!react) begin
					nextState = random;
					led = 0;
				end
				else  begin
				   nextState = idle;
					led = 0;
				end
			random:
				if(downcount) begin
					nextState = reaction;
				end else begin
					led = 0;
					nextState = random;
				end
			reaction: 
				if(!react) begin
					if(score < high_score || high_score == 0) begin
						high_score = score;
						nextState = done;
						led = 0;
					end else begin
						nextState = done;
						led = 0;
					end
				end
				else  begin
				   nextState = reaction;
					led = 1;
				end
			done: 
				nextState = done;
		endcase
		
		if (!reset)
		begin
				nextState = idle;		
		end
	end
endmodule
