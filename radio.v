// ****************** Radio.v ****************
module Radio(ALARM_Radio , _1Hz,nCR,AdjMinkey,AdjHrkey);
  	//input  _1kHzIN, _500Hz;   //定义输入端口变量
	//input _10Hz,_5Hz;
	input  _1Hz, nCR,AdjMinkey,AdjHrkey; //定义输入端口变量
	wire [7:0] Hour,Minute, Second; 
	wire MinCP,HrCP;
	output  ALARM_Radio;    //定义输出端口变量
	reg  ALARM_Radio;       //说明变量的类型
	supply1 Vdd;
	assign MinCP = AdjMinkey ? _1Hz : (Second==8'h59);
	assign HrCP = AdjHrkey ? _1Hz: ({Minute, Second}==16'h5959);	
	counter60 US1(Second, nCR, Vdd, _1Hz);      //秒计数器     
	counter60 US2(Minute, nCR, Vdd, ~MinCP);    //分计数器
	counter24 US3(Hour[7:4], Hour[3:0], nCR, Vdd, ~HrCP);
    always @(Hour or Minute or Second)   //generat alarm signal
        if (Minute==8'h59&&Second==8'h59)
		   begin ALARM_Radio =1'b1;end
		else ALARM_Radio =1'b0;
endmodule