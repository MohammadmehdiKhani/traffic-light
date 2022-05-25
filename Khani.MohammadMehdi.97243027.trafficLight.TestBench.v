`include "traffic_light.v"
`timescale 100ns/1ns

module traffic_light_tb ();

    reg reset;
    reg clock;

    reg [7:0] lastA;
    reg [7:0] lastB;

    wire [2:0] A;
    wire [2:0] B;

    traffic_light my_traffic_light(
        .clock(clock),
        .reset(reset),
        .lastA(lastA),
        .lastB(lastB),
        .A(A),
        .B(B)
    );


    initial 
    begin
        clock = 1'b1;
        forever #1 clock = ~clock ;
    end     

    initial 
    begin
        
        reset = 1'b1;
        #10;

        reset = 1'b0;
        #50

        lastA = 8'b00001000;
        lastB = 8'b00000010;
        #500;

        lastA = 8'b00000010;
        lastB = 8'b00000010;
        #100

        lastA = 8'b00100000;        
        lastB = 8'b00000010;
        #100

        $stop;
    end 
    
endmodule
