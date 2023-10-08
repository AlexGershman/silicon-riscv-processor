module pipeline(
    input wire clk,
    input wire reset,
    output reg [2:0] state
    );

//----------------------------------------------------------------------
//  Create a 5 stage pipeline
//----------------------------------------------------------------------

    localparam  STATE_IF = 3'b000;
                STATE_ID = 3'b001;
                STATE_EX = 3'b010;
                STATE_MM = 3'b011;
                STATE_WB = 3'b100;

//----------------------------------------------------------------------
//  Store current and next states in registers
//----------------------------------------------------------------------

    reg[2:0] current_state;
    reg[2:0] next_state;

//----------------------------------------------------------------------
//  Handle reset & state transitions
//----------------------------------------------------------------------

    always @ (posedge clk) begin
        if (reset)  current_state <= STATE_IF;
        else        current_state <= next_state;
    end

//----------------------------------------------------------------------
//  Define state transitions: IF -> ID -> EX -> MM -> WB
//----------------------------------------------------------------------

    always @ (*) begin
        next_state <= current_state;
        case(current_state):
            STATE_IF: next_state <= STATE_ID;
            STATE_ID: next_state <= STATE_EX;
            STATE_EX: next_state <= STATE_MM;
            STATE_MM: next_state <= STATE_WB;
            STATE_WB: next_state <= STATE_IF;
        endcase
    end

//----------------------------------------------------------------------
//  Output the current state
//----------------------------------------------------------------------
    
    always @ ( * ) begin
        state <= current_state;
    end

endmodule