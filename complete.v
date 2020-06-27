//静态数码管
module SEG7_LUT(oSEG, iDIG) ;
	input[3:0]iDIG; //二进制数或BCD输入
	output reg [6:0] oSEG;//7段码输出
always@(iDIG)//BCD码输入→七段码输出
begin//用case语句实现真值表
case (iDIG)//gfedcba
	4'h1: oSEG=7'b111_1001;//79
	4'h2: oSEG=7'b010_0100;//24
	4'h3: oSEG=7'b011_0000;//30
	4'h4: oSEG=7'b001_1001;//19
	4'h5: oSEG=7'b001_0010;//12
	4'h6: oSEG=7'b000_0010;//02
	4'h7: oSEG=7'b111_1000;//78
	4'h8: oSEG=7'b000_0000;//00
	4'h9: oSEG=7'b001_1000;//18
	4'ha: oSEG=7'b000_1000;//
	4'hb: oSEG=7'b000_0011;//
	4'hc: oSEG=7'b100_0110;//
	4'hd: oSEG=7'b010_0001;//
	4'he: oSEG=7'b000_0110;//
	4'hf: oSEG=7'b000_1110;//
	4'h0: oSEG=7'b100_0000;//40
	endcase
end
endmodule
/********complete clk************/
module Complete_Clock (hex,segctrl, ALARM, CLK_50, AdjMinkey, 
AdjHrkey, Set_Min, Set_Hr, nCR);
	input  CLK_50;    //系统的输入时钟信号
	input  nCR;        //系统总清零信号
	input  AdjMinkey, AdjHrkey;  //校正计时器小时、分钟的输入按键
	input [7:0] Set_Hr, Set_Min;  //设定的闹钟时间输出信号
	output ALARM;       //仿电台或闹钟的声音信号输出
	output [6:0]hex;
	output reg [5:0]segctrl;
	reg [3:0]data;
	reg [3:0]times;
	initial times = 0;
	wire _1Hz;         //分频器的输出信号  
	wire  ALARM_Radio;  //仿电台报时信号输出
	wire  ALARM_Clock;  //闹钟的信号输出
	wire [7:0] Hour, Minute, Second; //计时器的输出信号
	misaka UP(.nRST(nCR),
			.CLK_50(CLK_50),
			._1Hz(_1Hz));
	top_clock TPCLK(Hour, Minute, Second, _1Hz, nCR, AdjMinkey, AdjHrkey); //计时主体电路
	Radio RA(ALARM_Radio , _1Hz,nCR,AdjMinkey,AdjHrkey); //仿电台整点报时
	BELL BL(ALARM_Clock, Set_Hr, Set_Min,_1Hz,nCR, AdjMinkey, AdjHrkey); //定时闹钟模块
	//=============== 扬声器总控制模块 ========
    assign ALARM = ALARM_Radio||ALARM_Clock; 
	//---------------数码管显示-------------
	initial data<=0;
	always @ (posedge CLK_50)
	begin
	times <= times + 2'b1;
	//segctrl<=0;
	if(times == 6)
		times <= 2'b0;
	end
	always @ (posedge CLK_50)
	begin
	if(times == 1)
	begin
	data <= Second[3:0];
	segctrl <= 6'b00_00_01;
	end
	else if(times == 2)
	begin
	data <= Second[7:4];
	segctrl <= 6'b00_00_10;
	end
	else if(times == 3)
	begin
	data <= Minute[3:0];
	segctrl <= 6'b00_01_00;
	end
	else if(times == 4)
	begin
	data <= Minute[7:4];
	segctrl <= 6'b00_10_00;
	end
	else if(times == 5)
	begin
	data <= Hour[3:0];
	segctrl <= 6'b01_00_00;
	end
	else if(times == 6)
	begin
	data <= Hour[7:4];
	segctrl <= 6'b10_00_00;
	end
	end
	SEG7_LUT hex0(hex,data);
endmodule
