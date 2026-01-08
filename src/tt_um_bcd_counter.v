module tt_um_bcd_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire enable,
    output reg [3:0] bcd_units,
    output reg [3:0] bcd_tens,
    output reg [3:0] bcd_hundreds
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bcd_units    <= 4'd0;
            bcd_tens     <= 4'd0;
            bcd_hundreds <= 4'd0;
        end else if (enable) begin
            // Contador de unidades
            if (bcd_units == 4'd9) begin
                bcd_units <= 4'd0;
                // Contador de decenas
                if (bcd_tens == 4'd9) begin
                    bcd_tens <= 4'd0;
                    // Contador de centenas
                    if (bcd_hundreds == 4'd9) begin
                        bcd_hundreds <= 4'd0;
                    end else begin
                        bcd_hundreds <= bcd_hundreds + 1;
                    end
                end else begin
                    bcd_tens <= bcd_tens + 1;
                end
            end else begin
                bcd_units <= bcd_units + 1;
            end
        end
    end

endmodule

