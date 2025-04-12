module counters #(
    parameter int CLKFREQ = 27000000
) (
    input clk,
    input rst,
    input [7:0] switch,
    input btn1,
    output wire [3:0] digits,
    output wire [7:0] segments,
    output wire [15:0] dat
);
  wire ce1ms;
  reg [20:0] freq_decimal;
  sevenseg_display #(
      .CLKFREQ(CLKFREQ)
  ) display (
      .clk(clk),
      .ce1ms(ce1ms),
      .ptr(switch[5:4]),
      .dat(freq_decimal),
      .an(digits),
      .seg(segments)
  );

  wire ce1s_n_ms;
  gennms_1s #(
      .N(25)
  ) gen25ms_1s (
      .clk (clk),
      .tmod(switch[7]),
      .ceo (ce1s_n_ms),
      .ce  (ce1ms)
  );

  reg [15:0] freq;
  freqcounter #(
      .WIDTH(16)
  ) freqcounter (
      .ce  (ce1ms),
      .clk (clk),
      .ovf (ce1s_n_ms),
      .freq(freq)
  );

  bin2bcd bin2bcd (
      .bin(freq),
      .bcd(freq_decimal)
  );
endmodule
