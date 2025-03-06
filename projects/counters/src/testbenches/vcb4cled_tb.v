module vcb4cled_tb;
  reg clk = 0;

  wire [3:0] q;
  wire tc;
  wire ceo;
  reg l;

  initial begin
    $dumpfile("vcb4cled_tb.vcd");
    $dumpvars(0, vcb4cled_tb);
    #0 l = 1'b1;
    #2 l = 1'b0;
    #64 $finish;
  end

  always #1 clk = !clk;

  vcb_m_cled #(
      .WIDTH(4)
  ) counter (
      .ce (1'b1),
      .up (1'b1),
      .di (4'b0110),
      .l  (l),
      .clk(clk),
      .clr(1'b0),
      .q  (q),
      .tc (tc),
      .ceo(ceo)
  );
endmodule
