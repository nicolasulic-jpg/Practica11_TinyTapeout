module project (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [7:0]  ui_in,
    output wire [7:0]  uo_out,
    input  wire [7:0]  uio_in,
    output wire [7:0]  uio_out,
    output wire [7:0]  uio_oe
);

    // -------------------------
    // Asignación de entradas
    // -------------------------
    wire enable;
    assign enable = ui_in[0];

    // -------------------------
    // Señales internas
    // -------------------------
    wire [3:0] bcd_units;
    wire [3:0] bcd_tens;
    wire [3:0] bcd_hundreds;

    // -------------------------
    // Instancia del diseño
    // -------------------------
    tt_um_bcd_counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .bcd_units(bcd_units),
        .bcd_tens(bcd_tens),
        .bcd_hundreds(bcd_hundreds)
    );

    // -------------------------
    // Asignación de salidas
    // -------------------------
    assign uo_out[3:0] = bcd_units;
    assign uo_out[7:4] = bcd_tens;

    // -------------------------
    // Pines no usados
    // -------------------------
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
uts to prevent warnings
  wire _unused = &{ena, uio_in[7;0], ui_in[7:1], 1'b0};
  

endmodule
