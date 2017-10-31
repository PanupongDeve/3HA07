`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:41:08 10/31/2017 
// Design Name: 
// Module Name:    keypad 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module keypad(clk,column,row,display,common);
		input [2:0] column;
		input clk;
		output [6:0] display;
		output [3:0] row;
		output common;
    
	 parameter s1 = 2'b00;
	 parameter s2 = 2'b01;
	 parameter s3 = 2'b10;
	 parameter s4 = 2'b11;
	 
	 parameter clk1 = 25000000/50000;
	 parameter clk2 = 25000000/500000;
	 reg [3:0] row;
	 reg [6:0] display;
	 reg com;
	 reg [1:0] state = s1;
	 assign common = 0;
	 reg sclk;
	 always@(posedge sclk)
		case(state)
		s1 : begin
			row <= 4'b1101; //row
			case(column)
				3'b110 : display <= 7'b0110000 ;
				3'b101 : display <= 7'b1101101 ;
				3'b011 : display <= 7'b1111001 ;
			endcase
			state <= s2;
		end
		s2 : begin
			row <= 4'b1011; //row
			case(column)
				3'b110 : display <= 7'b0110011 ;
				3'b101 : display <= 7'b1011011 ;
				3'b011 : display <= 7'b1011111 ;
			endcase
			state <= s3;
		end
		s3 : begin
			row <= 4'b0111; //row
			case(column)
				3'b110 : display <= 7'b1110000 ;
				3'b101 : display <= 7'b1111111 ;
				3'b011 : display <= 7'b1111011;
			endcase
			state <= s4;
		end
		s4 : begin
			row <= 4'b1110; //row
			case(column)
				3'b110 : display <= 7'b1001111 ;
				3'b101 : display <= 7'b1111110 ;
				3'b011 : display <= 7'b1000111 ;
			endcase
			state <= s1;
		end
	endcase

reg [31:0] cnt;
always@(posedge clk)
	begin
		if(cnt == clk2)
			begin sclk <= 1; cnt <= 0; end
			else begin sclk <= 0; cnt <= cnt + 1; end
			end
endmodule
 