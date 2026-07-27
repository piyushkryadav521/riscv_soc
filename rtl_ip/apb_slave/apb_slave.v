module apb_slave (

    input clk,
    input rst,

    input PSEL,
    input PENABLE,
    input PWRITE,

    input [31:0] PADDR,
    input [31:0] PWDATA,

    output reg [31:0] PRDATA,
    output reg PREADY,
    output reg PSLVERR

);

reg [31:0] reg_file [0:7];

reg [1:0] wait_counter;

integer i;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        PREADY <= 0;
        PSLVERR <= 0;
        PRDATA <= 0;

        wait_counter <= 0;

        for(i=0;i<8;i=i+1)
            reg_file[i] <= 0;

    end

    else
    begin

        PREADY <= 0;
        PSLVERR <= 0;

        if(PSEL && PENABLE)
        begin

            if(wait_counter==2)
            begin

                PREADY <= 1;

                wait_counter <= 0;

                case(PADDR[4:2])

                    3'd0:
                    begin
                        if(PWRITE)
                            reg_file[0] <= PWDATA;
                        else
                            PRDATA <= reg_file[0];
                    end

                    3'd1:
                    begin
                        if(PWRITE)
                            reg_file[1] <= PWDATA;
                        else
                            PRDATA <= reg_file[1];
                    end

                    3'd2:
                    begin
                        if(PWRITE)
                            reg_file[2] <= PWDATA;
                        else
                            PRDATA <= reg_file[2];
                    end

                    3'd3:
                    begin
                        if(PWRITE)
                            reg_file[3] <= PWDATA;
                        else
                            PRDATA <= reg_file[3];
                    end

                    3'd4:
                    begin
                        if(PWRITE)
                            reg_file[4] <= PWDATA;
                        else
                            PRDATA <= reg_file[4];
                    end

                    3'd5:
                    begin
                        if(PWRITE)
                            reg_file[5] <= PWDATA;
                        else
                            PRDATA <= reg_file[5];
                    end

                    3'd6:
                    begin
                        if(PWRITE)
                            reg_file[6] <= PWDATA;
                        else
                            PRDATA <= reg_file[6];
                    end

                    3'd7:
                    begin
                        if(PWRITE)
                            reg_file[7] <= PWDATA;
                        else
                            PRDATA <= reg_file[7];
                    end

                    default:
                    begin
                        PSLVERR <= 1;
                    end

                endcase

            end

            else
            begin

                wait_counter <= wait_counter + 1;

            end

        end

    end

end

endmodule