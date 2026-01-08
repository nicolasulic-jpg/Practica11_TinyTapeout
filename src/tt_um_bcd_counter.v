module tt_um_bcd_counter (
    input  wire        clk,        // Clock
    input  wire        rst_n,          // Reset activo en bajo
    input  wire        ena,            // Enable requerido por Tiny Tapeout
    input  wire [7:0]  ui_in,          // Entradas de usuario
    output wire [7:0]  uo_out,         // Salidas de usuario
    input  wire [7:0]  uio_in,         // IO bidireccional (no usado)
    output wire [7:0]  uio_out,        // IO bidireccional (no usado)
    output wire [7:0]  uio_oe          // Output enable IO
);

    // -------------------------
    // Registros BCD
    // -------------------------
    reg [3:0] bcd_units;
    reg [3:0] bcd_tens;
    reg [3:0] bcd_hundreds;

    // -------------------------
    // Lógica secuencial
    // -------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bcd_units    <= 4'd0;
            bcd_tens     <= 4'd0;
            bcd_hundreds <= 4'd0;
        end else if (ena) begin
            if (bcd_units == 4'd9) begin
                bcd_units <= 4'd0;
                if (bcd_tens == 4'd9) begin
                    bcd_tens <= 4'd0;
                    if (bcd_hundreds == 4'd9)
                        bcd_hundreds <= 4'd0;
                    else
                        bcd_hundreds <= bcd_hundreds + 4'd1;
                end else begin
                    bcd_tens <= bcd_tens + 4'd1;
                end
            end else begin
                bcd_units <= bcd_units + 4'd1;
            end
        end
    end

    // -------------------------
    // Salidas
    // -------------------------
    assign uo_out[3:0] = bcd_units;
    assign uo_out[7:4] = bcd_tens;

    // -------------------------
    // IOs no usados
    // -------------------------
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // -------------------------
    // Evitar warnings
    // -------------------------
    wire _unused = &{ui_in, uio_in, bcd_hundreds, 1'b0};

endmodule




