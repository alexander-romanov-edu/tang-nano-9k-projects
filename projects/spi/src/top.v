`define WIDTH 13

module top (
    input clk,
    input [7:0] switch,
    input btn0,
    input btn1,

    output wire [3:0] digits,
    output wire [7:0] segments,
    output wire [7:0] led
);
  reg [`WIDTH-1:0] mtx_dat = 13'h1dad;
  reg [`WIDTH-1:0] stx_dat = 13'h0ced;

  wire rst = ~btn0;
  wire load;
  reg led_state = 0;

  always @(posedge load) begin
    led_state <= !led_state;
  end

  spi #(
      .CLKFREQ(27000000),
      .WIDTH  (`WIDTH)
  ) spi_top (
      .clk(clk),
      .rst(rst),
      .sw(switch[7:0]),
      .digits(digits),
      .segments(segments),
      .load(load),
      .mtx_dat(mtx_dat),
      .stx_dat(stx_dat)
  );

  always @(negedge load) begin
    mtx_dat <= mtx_dat + 1;
    stx_dat <= stx_dat + 1;
  end

  assign led[0] = led_state;
endmodule
