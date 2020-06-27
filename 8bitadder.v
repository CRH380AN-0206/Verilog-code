//八位加法器
module adder(Sum, Cout, A, B, Cin);
	input A, B, Cin;
	output Sum,Cout;
	assign Sum=A^B^Cin;
	assign Cout=(A & B)|(A & Cin)|(B & Cin);
endmodule
/******************************/
module yukino(S,C7,A,B,C_1);
	input[7:0]A,B;
	input C_1; 
	output [7:0]S;
	output C7;
	wire [6:0]C;
	adder U0_FA (S[0],C[0],A[0],B[0],C_1);
	adder U1_FA (S[1],C[1],A[1],B[1],C[0]);
	adder U2_FA (S[2],C[2],A[2],B[2],C[1]);
	adder U3_FA (S[3],C[3],A[3],B[3],C[2]);
	adder U4_FA (S[4],C[4],A[4],B[4],C[3]);
	adder U5_FA (S[5],C[5],A[5],B[5],C[4]);
	adder U6_FA (S[6],C[6],A[6],B[6],C[5]);
	adder U7_FA (S[7],C7,A[7],B[7],C[6]);
endmodule

