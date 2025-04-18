`define WIDTH 13

module top (
    input clk,
    input [7:0] switch,
    input btn0,
    input btn1,

    output wire [3:0] digits,
    output wire [7:0] segments,
    output wire [7:0] led,

    output wire load,
    output wire mosi,
    output wire miso,
    output wire sclk
);
  reg [`WIDTH-1:0] mtx_dat = 13'h2cc;
  reg [`WIDTH-1:0] stx_dat = 13'h6d9;

  wire rst = ~btn0;
  reg led_state = 0;
  wire ce1s_n_ms;

  always @(posedge load) begin
    led_state[0] <= !led_state[0];
  end

  spi #(
      .CLKFREQ(27000000),
      .SPIFREQ(10000),
      .WIDTH  (`WIDTH)
  ) spi_top (
      .clk(clk),
      .rst(rst),
      .sw(switch[7:0]),
      .digits(digits),
      .segments(segments),
      .sclk(sclk),
      .miso(miso),
      .mosi(mosi),
      .load(load),
      .mtx_dat(mtx_dat),
      .stx_dat(stx_dat),
      .ce1s_n_ms(ce1s_n_ms)
  );

  assign led[0] = led_state;
endmodule
