`timescale 1ms/1ms
module completetest;
	reg  CLK_50;    //系统的输入时钟信号
	reg  nCR;        //系统总清零信号
	
	reg  AdjMinkey, AdjHrkey;  //校正计时器小时、分钟的输入按键
	reg [7:0] Set_Hr, Set_Min;  //设定的闹钟时间输出信号
	wire hex,segctrl; //计时器的输出信号
	wire ALARM;       //仿电台或闹钟的声音信号输出
	Complete_Clock RPT(hex,segctrl, ALARM, CLK_50, AdjMinkey, AdjHrkey, Set_Min, Set_Hr, nCR);
	initial
	begin
	AdjMinkey=1'b0;
	AdjHrkey=1'b0;
	Set_Hr=8'h01;
	Set_Min=8'h01;
	end
	initial
	begin
	nCR=1'b0;
	#1 nCR=1'b1;
	end
	always
	begin
		CLK_50=1'b0;
		CLK_50=#10 1'b1;
		#10;
	end
endmodule