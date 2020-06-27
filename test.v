//八位时序乘法器激励
`timescale 1ms/1ms
module testofregclk;
	reg [7:0]x,y;
	reg clk,clr_;
	wire [15:0]z_opt;
	_8bitmultclk Mayaka(x,y,z_opt,clk,clr_);
	initial
	begin
		x=8'd2;
		y=8'd2;
	#8192 $stop;
	end
	initial
	begin
	clr_=1'b0;
	#1 clr_=1'b1;
	end
	always
	begin
		clk=1'b1;
		clk=#1 1'b0;
		#1;//建议频率尽可能大
	end
	always
	begin
	#100 x=x+8'd2;
	end
endmodule