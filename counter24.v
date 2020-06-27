//*************文件名：counter24.v  (BCD计数: 0~23)*************
module counter24 (CntH, CntL, nCR, EN, CP);
	input CP, nCR, EN;    //分别为计时脉冲CP、清零信号nCR和使能信号EN
  	output [3:0] CntH, CntL;  //小时计数器的十位和个位输出信号，
	reg    [3:0] CntH, CntL;  //输出为8421 BCD码
	always @(posedge CP or negedge nCR) 
    begin
      if(~nCR)     {CntH, CntL} <= 8'h00;     //异步清零
      else if(~EN) {CntH, CntL} <= {CntH, CntL}; //对使能信号无效的处理
	else if ((CntH>2)||(CntL>9)||((CntH==2)&&(CntL>=3)))
	{CntH, CntL} <= 8'h00; 	 //对小时计数器出错的处理
	 else if ((CntH==2)&&(CntL<3))       //进行20～23计数
		     begin  CntH <= CntH;  CntL <= CntL + 1'b1; end
      else if (CntL==9)     //小时十位的计数
		     begin  CntH <= CntH + 1'b1;  CntL <= 4'b0000; end
	  else                //小时个位的计数
	begin  CntH <= CntH;  CntL <= CntL + 1'b1; end
	end
endmodule