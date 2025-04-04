module counters_tb;
  reg clk = 0;

  initial begin
    $dumpfile("counters_tb.vcd");
    $dumpvars(0, counters_tb);
    #131072 $finish;
  end

  always begin
    #1 clk = !clk;
  end

  counters #(
      .CLKFREQ(2000)
  ) counters (
      .clk(clk),
      .rst(1'b0),
      .switch(8'b10000000)
  );
endmodule
