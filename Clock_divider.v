module clock_divider(clk,clk_out,reset);
input clk,reset;
reg [15:0] count_reg = 0;
output reg clk_out = 0;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        count_reg <= 0;
        clk_out <= 0;
    end else begin
        if (count_reg < 24999) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 0;
            clk_out <= ~clk_out;
        end
    end
end
endmodule
