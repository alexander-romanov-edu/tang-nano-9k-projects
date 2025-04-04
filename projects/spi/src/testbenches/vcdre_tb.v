module vcdre_tb;
  reg clk = 0;

  initial begin
    $dumpfile("vcdre_tb.vcd");
    $dumpvars(0, vcdre_tb);
    #32 $finish;
  end

  always #1 clk = !clk;

  wire [3:0] q;
  wire tc;
  wire ceo;

  vcd_re #() counter (
      .ce (1'b1),
      .clk(clk),
      .rst(1'b0),
      .q  (q),
      .tc (tc),
      .ceo(ceo)
  );
endmodule
