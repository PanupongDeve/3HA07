module keyscan(
    input clk,
    input [2:0] column,
    output reg [3:0] row,
    output reg [6:0] display,
    output common
);

parameter st1 = 2'b00;
parameter st2 = 2'b01;
parameter st3 = 2'b10;
parameter st4 = 2'b11;

assign common = 0;

reg [1:0] state = st1;

reg sclk;
reg [31:0] cnt;

    always@(posedge sclk)
        case (state)
            st1: begin
                row <= 4'b0001;
                case (column)
                    3'b001 : display <= 7'b0110000;
                    3'b010 : display <= 7'b1101101;
                    3'b100 : display <= 7'b1111001;
                endcase
                state <= st2;
            end
            
            st2: begin
                row <= 4'b0010;
                case (column)
                    3'b001 : display <= 7'b0110011;
                    3'b010 : display <= 7'b1011011;
                    3'b100 : display <= 7'b1111001;
                endcase
                state <= st3
            end

            st3: begin
                row <= 4'b0100;
                case (column)
                    3'b001 : display <= 7'b1110000;
                    3'b010 : display <= 7'b1111111;
                    3'b100 : display <= 7'b0011111;
                endcase
                state <= st4;
            end

            st4: begin
                row <= 4'b1000;
                case (column)
                    3'b001 : display <= 7'b1110111;
                    3'b010 : display <= 7'b1111110;
                    3'b100 : display <= 7'b0011111;
                endcase
                state <= st1;
            end
            default : display <= 7'b1000111;
        endcase

    always@(posedge clk)
        begin
            if(cnt == 25000000)
                begin
                    sclk <= ~sclk;
                    snt <= 0;
                end
            else
                cnt <= cnt + 1;
        end
endmodule