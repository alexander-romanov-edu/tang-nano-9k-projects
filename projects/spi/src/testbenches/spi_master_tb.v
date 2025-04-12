module spi_master_tb;
  localparam int WIDTH = 13;

  reg clk = 0;
  reg st = 0;

  initial begin
    $dumpfile("spi_master_tb.vcd");
    $dumpvars(0, spi_master_tb);
    #1 st = 1;
    #1 st = 0;
    #1024 $finish;
  end

  always #1 clk = !clk;

  spi_master #(
      .WIDTH  (WIDTH),
      .CLKFREQ(16),
      .SPIFREQ(2)
  ) master (
      .st (st),
      .clk(clk),
      .din(13'b1001001001001)
  );
endmodule
