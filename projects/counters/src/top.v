module top (
    input clk,
    input rst,
    input [7:0] switch,
    input btn1,
    output wire [3:0] digits,
    output wire [7:0] segments,
    output wire [7:0] led
);

  counters #(
      .CLKFREQ(`CLKFREQ)
  ) counters_top (
      .clk(clk),
      .rst(~rst),
      .btn1(btn1),
      .switch(switch),
      .digits(digits),
      .segments(segments),
      .dat(dat)
  );

  wire [15:0] dat;

  assign led = dat[7:0];
endmodule
