module vcj4re_tb;
  reg clk = 0;

  initial begin
    $dumpfile("vcj4re_tb.vcd");
    $dumpvars(0, vcj4re_tb);
    #32 $finish;
  end

  always #1 clk = !clk;

  wire [3:0] q;
  wire tc;
  wire ceo;

  vcj_m_re #(
      .WIDTH(4)
  ) counter (
      .ce (1'b1),
      .clk(clk),
      .rst(1'b0),
      .q  (q),
      .tc (tc),
      .ceo(ceo)
  );
endmodule
