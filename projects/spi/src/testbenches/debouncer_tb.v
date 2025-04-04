module debouncer_tb;
  reg clk = 0;
  reg ce1ms = 0;
  reg btn_in = 0;

  initial begin
    $dumpfile("debouncer_tb.vcd");
    $dumpvars(0, debouncer_tb);
    #10 btn_in = 1;
    #1 btn_in = 0;
    #3 btn_in = 1;
    btn_in = 0;
    #5;
    btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #1 btn_in = 0;
    #1 btn_in = 1;
    #128 $finish;
  end

  always #1 clk = !clk;

  always begin
    #11 ce1ms = !ce1ms;
    #1 ce1ms = !ce1ms;
  end

  debouncer debouncer (
      .clk(clk),
      .btn_in(btn_in),
      .ce1ms(ce1ms)
  );
endmodule
