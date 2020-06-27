module Divider50MHz(CLK_50M,nCR,CLK_1HzOut);
	parameter N=25;//位宽
	parameter CLK_Freq=5000;
	parameter OUT_Freq=1;
	input nCR,CLK_50M;
	output reg CLK_1HzOut;
	reg[N-1:0] Count_DIV;
	always@(posedge CLK_50M or negedge nCR)
	begin
	if(~nCR) begin
	CLK_1HzOut<=0;
	Count_DIV<=0;
	end
	else begin
	if(Count_DIV<(CLK_Freq/(2*OUT_Freq)-1))
	Count_DIV<=Count_DIV+1'b1;
	else begin
	Count_DIV<=0;
	CLK_1HzOut<=~CLK_1HzOut;
	end
	end
	end
endmodule
//**********************************************************
module misaka(nRST,CLK_50,_1Hz);
	input CLK_50, nRST;
	//输入端口声明
	output _1Hz;
	//输出端口声明
	Divider50MHz	U3(.CLK_50M(CLK_50),//实例引用子模块
					.nCR (nRST),
					.CLK_1HzOut(_1Hz));//10Hz
	defparam 		U3.N=6,
					U3.CLK_Freq=50,
					U3.OUT_Freq= 1;
	
endmodule
