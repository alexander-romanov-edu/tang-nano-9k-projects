module vcbd4se_tb;
  reg clk = 0;

  initial begin
    $dumpfile("vcbd4se_tb.vcd");
    $dumpvars(0, vcbd4se_tb);
    #32 $finish;
  end

  always #1 clk = !clk;

  wire [3:0] q;
  wire tc;
  wire ceo;

  vcbd_m_se #(
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
