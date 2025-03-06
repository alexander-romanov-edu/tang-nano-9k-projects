module vcgray4re_tb;
  reg clk = 0;

  initial begin
    $dumpfile("vcgray4re_tb.vcd");
    $dumpvars(0, vcgray4re_tb);
    #32 $finish;
  end

  always #1 clk = !clk;

  wire [3:0] y;
  wire tc;
  wire ceo;

  vcgray4re counter (
      .ce (1'b1),
      .clk(clk),
      .rst(1'b0),
      .y  (y),
      .tc (tc),
      .ceo(ceo)
  );
endmodule
