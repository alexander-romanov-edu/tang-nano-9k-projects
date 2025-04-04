module SPIMasterSlaveTop_tb;
  initial begin
    $dumpfile("spi_tb.vcd");
    $dumpvars(0, SPIMasterSlaveTop_tb);
    #500 $finish;
  end
  // Parameters
  parameter DATA_WIDTH = 8;

  // Testbench signals
  reg clk;
  reg reset;
  reg start;

  // Instantiate the top module
  SPIMasterSlaveTop #(
    .DATA_WIDTH(DATA_WIDTH)
  ) uut (
    .clk(clk),
    .reset(reset),
    .start(start)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #2 clk = ~clk; // 10ns clock period (100 MHz)
  end

  // Testbench logic
  initial begin
    // Initialize signals
    reset = 1;
    start = 0;
    #8;

    // Release reset
    reset = 0;
    #8;

    // Start the SPI transaction
    start = 1;
    #4;
    start = 0;

    // Wait for the transaction to complete
    #600;

    // End simulation
    #50;
    $finish;
  end
endmodule
