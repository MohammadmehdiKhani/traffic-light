
module traffic_light (
    input reset,
    input clock,
    input [7:0] lastA,
    input [7:0] lastB,

    output reg [2:0] A,
    output reg [2:0] B
);
reg [2:0] _repeat;    
reg [2:0] state;
reg [2:0] _time;


localparam 
S0 = 3'b000,
S1 = 3'b001,
S2 = 3'b010,
S3 = 3'b011,
S4 = 3'b100,
S5 = 3'b101;

localparam
fiveSecound = 3'd4,
oneSecound = 3'd0;

 always @(posedge clock or posedge reset)


if (reset == 1) begin
    state <=S0;
    _time <= 0;
    _repeat <= 0;
end else
    case (state)
//A is green
//B is redf
        S0: if (_time < fiveSecound)
            begin
            state <= S0;
            _time <= _time + 1;
            end 

            else if (lastA/lastB > 4 && (_repeat ==  0 || _repeat== 1 || _repeat== 2 || _repeat== 3 ))
            begin   
            state <= S0;
            _time <= 0;
            _repeat <= _repeat + 1;
            end 

            else if (lastA/lastB > 2 && (_repeat ==  0 || _repeat== 1))
            begin
            state <= 0;
            _time <= 0;
            _repeat <= _repeat + 1;    
            end

            else  
            begin
            state <= S1;
            _time <= 0;
            _repeat <= 0;                
            end
        
            
            
//A is yellow
//B is red
        S1: if (_time < oneSecound) 
        begin
            state <= S1;
            _time <= _time + 1;
        end

        else 
        begin
            state <= S2;
            _time <= 0;
        end
//A is red
//B is red
        S2: if (_time < oneSecound) 
        begin
            state <= S2;
            _time <= _time + 1;
        end

        else 
        begin
            state <= S3;
            _time <= 0;
        end
//A is red
//B is green
        S3: if (_time < fiveSecound) 
        begin
            state <= S3;
            _time <= _time + 1;
        end
        
        else if (lastB/lastA > 4 && (_repeat ==  0 || _repeat== 1 || _repeat== 2 || _repeat== 3 )) 
        begin
            state <= S3;
            _time <= 0;
            _repeat <= _repeat + 1;
        end

        else if (lastB/lastA > 2 && (_repeat ==  0 || _repeat== 1))
        begin
            state <= S3;
            _time <= 0;
            _repeat <= _repeat + 1;    
        end

        else
        begin
            state <= S4;
            _time <= 0;
            _repeat <= 0;
        end
//A is red
//B is yellow
        S4: if (_time < oneSecound) 
        begin
            state <= S4;
            _time <= _time + 1;
        end

        else 
        begin
            state <= S5;
            _time <= 0;
        end
//A is red
//B is red
        S5: if (_time < oneSecound) 
        begin
            state <= S5;
            _time <= _time + 1;
        end 
        else 
        begin
            state <= S0;
            _time <= 0;
        end

        default: state<= S0; 
    endcase

    always @(*) begin
        
            case (state)
               S0 : begin
                   A <= 3'b001;
                   B <= 3'b100;
                    end

               S1 : begin
                   A <= 3'b010;
                   B <= 3'b100;
                    end


               S2 : begin
                   A <= 3'b100;
                   B <= 3'b100;
                    end


               S3 : begin
                   A <= 3'b100;
                   B <= 3'b001;
                    end


               S4 : begin
                   A <= 3'b100;
                   B <= 3'b010;
                    end

               S5 : begin
                   A <= 3'b100;
                   B <= 3'b100;
                    end


             default: 
                 begin
                       A <= 3'b100;
                       B <= 3'b100;
                 end
            endcase

    end
    
endmodule
