//八位组合乘法器激励块
`timescale 1ms/1ms
module cuttest;
	reg [7:0]x,y;
	//input c;
	wire [15:0]z;
	_8bitmult Chitanda(x,y,z);
	initial
	begin
		x=8'd2;
		y=8'd2;
	#128 $stop;
	end
	always
	begin
	#1 x=x+8'd2;
	end
endmodule