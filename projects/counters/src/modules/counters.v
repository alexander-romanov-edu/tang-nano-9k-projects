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
  sevenseg_display #(
      .CLKFREQ(CLKFREQ)
  ) display (
      .clk(clk),
      .ce1ms(ce1ms),
      .ptr(switch[5:4]),
      .dat(dat[15:0]),
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

  wire vcj4re_ceo;
  vcj_m_re #(
    .WIDTH(4)
  ) vcj4re (
      .ce (ce1s_n_ms),
      .clk(clk),
      .rst(rst),
      .q  (dat[3:0]),
      .ceo(vcj4re_ceo)
  );

  wire vcd_re_ceo;
  vcd_re vcd_re (
      .ce (vcj4re_ceo),
      .clk(clk),
      .rst(rst),
      .q  (dat[7:4]),
      .ceo(vcd_re_ceo)
  );

  wire vcb4re_ceo;
  vcb_m_re #(
      .WIDTH(4)
  ) vcb4re (
      .ce (vcd_re_ceo),
      .clk(clk),
      .rst(rst),
      .q  (dat[11:8]),
      .ceo(vcb4re_ceo)
  );

  vcb_m_cled #(
      .WIDTH(4)
  ) vcb_m_cled (
      .ce (vcb4re_ceo),
      .up (switch[6]),
      .di (switch[3:0]),
      .l  (btn1),
      .clk(clk),
      .clr(rst),
      .q  (dat[15:12])
  );
endmodule
