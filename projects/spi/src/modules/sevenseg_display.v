module sevenseg_display #(
    parameter int CLKFREQ = 27000000
) (
    input clk,
    input [15:0] dat,
    input [1:0] ptr,
    output wire [3:0] an,
    output wire [7:0] seg,
    output wire ce1ms
);
  wire [3:0] dig;
  wire [1:0] adr_dig;

  gen4an dd1 (
      .clk(clk),
      .q  (adr_dig),
      .ce (ce1ms),
      .an (an)
  );

  mux16_4 dd2 (
      .dat(dat),
      .digit_output(dig),
      .adr(adr_dig)
  );

  digits_sevenseg dd3 (
      .dig(dig),
      .seg(seg[6:0])
  );

  gen_p dd4 (
      .adr_an(adr_dig),
      .seg_p(seg[7]),
      .ptr(ptr)
  );

  gen1ms #(
      .CLKFREQ(CLKFREQ)
  ) dd5 (
      .clk  (clk),
      .ce1ms(ce1ms)
  );
endmodule
