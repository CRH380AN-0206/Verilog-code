//***************** counter60.v (BCD: 00~59)*************
//60进制计数器：调用10进制和6进制底层模块构成
module counter60(Cnt, nCR, EN, CP);
    input CP, nCR, EN;
    output [7:0] Cnt;       //模60计数器的输出信号
   wire  [7:0] Cnt;           //输出为8421 BCD码
    wire  ENP;                 //计数器十位的使能信号（中间变量）

 counter10 UC0 (Cnt[3:0], nCR, EN, CP);  //计数器的个位
 counter6  UC1 (Cnt[7:4], nCR, ENP, CP); //计数器的十位
assign ENP=EN&&(Cnt[3:0]==4'h9);  //产生计数器十位的使能信号

endmodule 