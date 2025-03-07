module freqcounter_tb;
  reg clk = 0;
  reg ovf = 0;
  reg [15:0] freq;

  initial begin
    $dumpfile("freqcounter_tb.vcd");
    $dumpvars(0, freqcounter_tb);
    #128 $finish;
  end

  always begin
    #1 clk = !clk;
  end

  always begin
    #1 ovf = 0;
    #4 ovf = 1;
  end

  freqcounter #(
      .WIDTH(16)
  ) counters (
      .ce  (clk),
      .ovf (ovf),
      .clk (clk),
      .freq(freq)
  );
endmodule
