//八位时序乘法器
module _8bitmultclk(x,y,z_opt,clk,clr_);
	input [7:0]x,y;
	input clk,clr_;
	output [15:0]z_opt;
	reg [7:0]mid_0;//x[i]&y0
	reg [7:0]mid_1;//x[i]&y1
	reg [7:0]mid_2;//x[i]&y2
	reg [7:0]mid_3;//x[i]&y3
	reg [7:0]mid_4;//x[i]&y4
	reg [7:0]mid_5;//x[i]&y5
	reg [7:0]mid_6;//x[i]&y6
	reg [7:0]mid_7;//x[i]&y7
	wire[7:0]result_0;//第0层全加器出口
	wire[7:0]result_1;//第1层全加器出口
	wire[7:0]result_2;//第2层全加器出口	
	wire[7:0]result_3;//第3层全加器出口 
	wire[7:0]result_4;//第4层全加器出口 
	wire[7:0]result_5;//第5层全加器出口 
	wire[7:0]result_6;//第6层全加器出口
	wire[7:0]regout_0;//第0层寄存器出口
	wire[7:0]regout_1;//第1层寄存器出口
	wire[7:0]regout_2;//第2层寄存器出口	
	wire[7:0]regout_3;//第3层寄存器出口 
	wire[7:0]regout_4;//第4层寄存器出口 
	wire[7:0]regout_5;//第5层寄存器出口 
	wire cout_0;
	wire cout_1; 
	wire cout_2; 
	wire cout_3; 
	wire cout_4; 
	wire cout_5; 
	wire cout_6;
	wire [15:0]z;
	//assign z[0]=x[0]&y[0]; 
	always@(x)
	begin:b0
		integer i;
		for(i=0;i<8;i=i+1)
		mid_0[i]=x[i]&y[0];
	end
	always@(x)
	begin:b1
		integer j;
		for(j=0;j<8;j=j+1)
		mid_1[j]=x[j]&y[1];
	end
	yukino u0(result_0,cout_0,{1'b0,mid_0[7:1]},mid_1,0);
	kuroko d0({cout_0,result_0[7:1]},regout_0,clk,clr_);
	always@(x)
	begin:b2
		integer k;
		for(k=0;k<8;k=k+1)
		mid_2[k]=x[k]&y[2];
	end
	yukino u1(result_1,cout_1,regout_0,mid_2,0);
	kuroko d1({cout_1,result_1[7:1]},regout_1,clk,clr_);
	always@(x)
	begin:b3
		integer l;
		for(l=0;l<8;l=l+1)
		mid_3[l]=x[l]&y[3];
	end
	yukino u2(result_2,cout_2,regout_1,mid_3,0);
	kuroko d2({cout_2,result_2[7:1]},regout_2,clk,clr_);
	always@(x)
	begin:b4
		integer m;
		for(m=0;m<8;m=m+1)
		mid_4[m]=x[m]&y[4];
	end
	yukino u3(result_3,cout_3,regout_2,mid_3,0);
	kuroko d3({cout_3,result_3[7:1]},regout_3,clk,clr_);
	always@(x)
	begin:b5
		integer n;
		for(n=0;n<8;n=n+1)
		mid_5[n]=x[n]&y[5];
	end
	yukino u4(result_4,cout_4,regout_3,mid_4,0);
	kuroko d4({cout_4,result_4[7:1]},regout_4,clk,clr_);
	always@(x)
	begin:b6
		integer p;
		for(p=0;p<8;p=p+1)
		mid_6[p]=x[p]&y[6];
	end
	yukino u5(result_5,cout_5,regout_4,mid_5,0);
	kuroko d5({cout_5,result_5[7:1]},regout_5,clk,clr_);
	always@(x)
	begin:b7
		integer q;
		for(q=0;q<8;q=q+1)
		mid_7[q]=x[q]&y[7];
	end
	yukino u6(result_6,cout_6,regout_5,mid_7,0);
	assign z[0] =mid_0[0];
	assign z[1] =result_0[0];
	assign z[2] =result_1[0];
	assign z[3] =result_2[0];
	assign z[4] =result_3[0];
	assign z[5] =result_4[0];
	assign z[6] =result_5[0];
	assign z[7] =result_6[0];
	assign z[8] =result_6[1];
	assign z[9] =result_6[2];
	assign z[10]=result_6[3];
	assign z[11]=result_6[4];
	assign z[12]=result_6[5];
	assign z[13]=result_6[6];
	assign z[14]=result_6[7];
	assign z[15]=cout_6;
	kuroko d6(z[7:0],z_opt[7:0],clk,clr_);
	kuroko d7(z[15:8],z_opt[15:8],clk,clr_);
endmodule
	
	
	
	