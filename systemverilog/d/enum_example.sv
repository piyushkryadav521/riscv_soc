module enum_example;

typedef enum logic [1:0] {

    IDLE,
    FETCH,
    EXECUTE,
    WRITEBACK

} state_t;

state_t state;

initial begin

    state = IDLE;

    #10 state = FETCH;

    #10 state = EXECUTE;

    #10 state = WRITEBACK;

end

endmodule