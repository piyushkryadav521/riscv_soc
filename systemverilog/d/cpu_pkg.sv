package cpu_pkg;

typedef logic [31:0] word_t;

typedef enum logic [1:0] {

    IDLE,
    FETCH,
    EXECUTE,
    WRITEBACK

} state_t;

endpackage