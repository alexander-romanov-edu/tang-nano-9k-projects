module top (
    input clk,
    input [7:0] switch,
    input btn0,
    input btn1,
    output wire [3:0] digits,
    output wire [7:0] segments,
    output wire [7:0] led
);
  wire rst = ~btn0;

  spi_master #(
  ) spi_top (
      .clk(clk),
      .reset(rst),
      .start(~btn1),
      .miso(~btn1),
      .switch(switch),
      .digits(digits),
      .segments(segments),
      .data_in(dat)
  );

  wire [15:0] dat;

  assign led = dat[7:0];
endmodule
