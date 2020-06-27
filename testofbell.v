`timescale 1us/1us
module testbell;
	reg [7:0] Set_Hr, Set_Min; //设定的闹铃时间(BCD码)
	reg  _1kHzIN, _500Hz, _1Hz; //定义输入端口变量
	//reg Set_Hr, Set_Min; //设定闹钟小时、分钟的输入键
	//reg CtrlBell; //控制闹钟的声音是否输出的按键 
	reg nCR, AdjMinkey, AdjHrkey;	
	wire  ALARM_Clock;   //定义输出端口变量
	BELL UB(ALARM_Clock, Set_Hr, Set_Min,_1kHzIN, _500Hz, _1Hz,nCR, AdjMinkey,AdjHrkey);
	initial
	begin
	AdjMinkey=1'b0;
	AdjHrkey=1'b0;
	Set_Hr=8'h00;
	Set_Min=8'h05;
	//CtrlBell=1'b1;
	end
	initial
	begin
	nCR=1'b0;
	#1 nCR=1'b1;
	end
	always
	begin
		_1Hz=1'b0;
		_1Hz=#500000 1'b1;
		#500000;
	end
	always
	begin
		_1kHzIN=1'b0;
		_1kHzIN=#500 1'b1;
		#500;
	end
	always
	begin
		_500Hz=1'b0;
		_500Hz=#1000 1'b1;
		#1000;
	end
endmodule