module spi #(
    parameter int WIDTH   = 13,
    parameter int CLKFREQ = 27000000,
    parameter int SPIFREQ = 100000
) (
    input [7:0] sw,

    output wire load,
    output wire sclk,
    output wire miso,
    output wire mosi,

    input st,
    input clk,
    input rst,

    output wire [ 3:0] digits,
    output wire [ 7:0] segments,
    output wire [15:0] dat,

    input reg [WIDTH-1:0] mtx_dat = 13'h1dad,
    input reg [WIDTH-1:0] stx_dat = 13'h0ced,

    output wire ce1s_n_ms
);

  reg [WIDTH-1:0] mrx_dat;
  reg [WIDTH-1:0] srx_dat;

  wire [WIDTH-1:0] sr_mtx;
  wire [WIDTH-1:0] sr_mrx;

  wire [WIDTH-1:0] sr_stx;
  wire [WIDTH-1:0] sr_srx;

  wire [7:0] cb_bit;
  wire ce_tact;
  wire ce1ms;

  sevenseg_display #(
      .CLKFREQ(CLKFREQ)
  ) display (
      .clk(clk),
      .ce1ms(ce1ms),
      .ptr(2'b00),
      .dat(dat),
      .an(digits),
      .seg(segments)
  );

  gennms_1s #(
      .N(25)
  ) gen25ms_1s (
      .clk (clk),
      .tmod(sw[7]),
      .ceo (ce1s_n_ms),
      .ce  (ce1ms)
  );

  assign st = ce1s_n_ms;

  mux64_16 mux (
      .dat({  /*0*/
        3'd0, mtx_dat,  /*1*/ 3'd0, stx_dat,  /*2*/ 3'd0, mrx_dat,  /*3*/ 3'd0, srx_dat
      }),
      .out(dat),
      .adr(sw[1:0])
  );

  spi_master #(
      .WIDTH  (WIDTH),
      .CLKFREQ(CLKFREQ),
      .SPIFREQ(SPIFREQ)
  ) master (
      .clk(clk),
      .st(st),
      .din(mtx_dat),
      .dout(mrx_dat),
      .load(load),
      .sclk(sclk),
      .mosi(mosi),
      .clr(rst),
      .miso(miso),
      .sr_mtx(sr_mtx),
      .sr_mrx(sr_mrx),
      .cb_bit(cb_bit),
      .ce_tact(ce_tact)
  );

  spi_slave #(
      .WIDTH(WIDTH)
  ) slave (
      .din(stx_dat),
      .dout(srx_dat),
      .load(load),
      .miso(miso),
      .sclk(sclk),
      .mosi(mosi),
      .sr_stx(sr_stx),
      .sr_srx(sr_srx),
      .clr(rst)
  );
endmodule
