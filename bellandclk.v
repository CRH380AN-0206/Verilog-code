// ****************** Bell.v ****************
module BELL (ALARM_Clock, Set_Hr, Set_Min,_1Hz,nCR, AdjMinkey, AdjHrkey);
	output reg ALARM_Clock;   //定义输出端口变量
	input [7:0] Set_Hr, Set_Min; //设定的闹铃时间(BCD码)
	input _1Hz; //定义输入端口变量
	wire [7:0] Hour, Minute,Second;  
	input nCR, AdjMinkey, AdjHrkey;
	// 定义内部节点信号
	supply1 Vdd;         //定义Vdd为高电平
	wire Time_EQU; //相等比较电路的输出
	wire MinCP, HrCP;    //分别为分钟、小时计数器时钟信号（中间变量）
//=============  Hour:Minute:Second counter =============
	//产生分钟计数器时钟信号。AdjMinKey=1，校正分钟；AdjMinKey=0，分钟正常计时
	assign MinCP = AdjMinkey ? _1Hz : (Second==8'h59);
	//产生小时计数器时钟信号。AdjHrKey =1，校正小时；AdjHrKey =0，小时正常计时
	assign HrCP = AdjHrkey ? _1Hz: ({Minute, Second}==16'h5959);	
	counter60 UT1(Second, nCR, Vdd, _1Hz);      //秒计数器     
	counter60 UT2(Minute, nCR, Vdd, ~MinCP);    //分计数器
	counter24 UT3(Hour[7:4], Hour[3:0], nCR, Vdd, ~HrCP); //小时计数器
	//比较闹钟的设定时间和计时器的当前时间是否相等
	always @(posedge _1Hz)
        begin
            if((Set_Hr == Hour) && (Set_Min == Minute))
                ALARM_Clock <= 1;
            else
                ALARM_Clock <= 0;
        end
endmodule


