module spi_test_slave #(
    parameter int WIDTH   = 13,
    parameter int CLKFREQ = 8,
    parameter int SPIFREQ = 2

) (
    output wire load,
    output wire sclk,
    output wire miso,
    output wire mosi,

    input st,
    input clk,
    input rst,

    input [WIDTH-1:0] mtx_dat,
    output wire [WIDTH-1:0] mrx_dat,
    output wire [WIDTH-1:0] sr_mtx,
    output wire [WIDTH-1:0] sr_mrx,
    output wire [7:0] cb_bit,
    output wire ce_tact,

    input [WIDTH-1:0] stx_dat,
    output wire [WIDTH-1:0] sr_stx,
    output wire [WIDTH-1:0] sr_srx,
    output wire [WIDTH-1:0] srx_dat
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
