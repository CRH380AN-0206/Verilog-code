// ******************  top_clock.v  ****************
module top_clock (Hour, Minute, Second, _1Hz, nCR, AdjMinkey, AdjHrkey);
  	input  _1Hz, nCR, AdjMinkey, AdjHrkey; //定义输入端口变量
	output [7:0] Hour, Minute, Second;  //定义输出端口变量
  	wire [7:0] Hour, Minute, Second;    //说明输出变量类型
	supply1 Vdd;         //定义Vdd为高电平
	//input en;
	wire MinCP, HrCP;    //分别为分钟、小时计数器时钟信号（中间变量）
//=============  Hour:Minute:Second counter =============
	//产生分钟计数器时钟信号。AdjMinKey=1，校正分钟；AdjMinKey=0，分钟正常计时
	assign MinCP = AdjMinkey ? _1Hz : (Second==8'h59);
	//产生小时计数器时钟信号。AdjHrKey =1，校正小时；AdjHrKey =0，小时正常计时
	assign HrCP = AdjHrkey ? _1Hz: ({Minute, Second}==16'h5959);	
	counter60 UT1(Second, nCR, Vdd, _1Hz);      //秒计数器     
	counter60 UT2 (Minute, nCR, Vdd, ~MinCP);    //分计数器
	counter24 UT3(Hour[7:4], Hour[3:0], nCR, Vdd, ~HrCP); //小时计数器
	
endmodule
