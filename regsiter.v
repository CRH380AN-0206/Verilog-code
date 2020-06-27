//八位不移位寄存器
module dff(Q,Q_,D,CP,CLR_);
	input D,CP,CLR_;
	output reg Q;
	output Q_;
	assign Q_=~Q;
	always@(posedge CP or negedge CLR_)
	if(~CLR_)
	Q<=1'b0;
	else
	Q<=D;
endmodule
module kuroko(ipt,opt,clk,clr_);
	input [7:0]ipt;
	input clk,clr_;
	output [7:0]opt;
	dff u0(.Q(opt[0]),.Q_(),.D(ipt[0]),.CP(clk),.CLR_(clr_));
	dff u1(.Q(opt[1]),.Q_(),.D(ipt[1]),.CP(clk),.CLR_(clr_));
	dff u2(.Q(opt[2]),.Q_(),.D(ipt[2]),.CP(clk),.CLR_(clr_));
	dff u3(.Q(opt[3]),.Q_(),.D(ipt[3]),.CP(clk),.CLR_(clr_));
	dff u4(.Q(opt[4]),.Q_(),.D(ipt[4]),.CP(clk),.CLR_(clr_));
	dff u5(.Q(opt[5]),.Q_(),.D(ipt[5]),.CP(clk),.CLR_(clr_));
	dff u6(.Q(opt[6]),.Q_(),.D(ipt[6]),.CP(clk),.CLR_(clr_));
	dff u7(.Q(opt[7]),.Q_(),.D(ipt[7]),.CP(clk),.CLR_(clr_));
endmodule