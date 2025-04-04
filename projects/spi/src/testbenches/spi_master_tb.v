module SPIMaster_tb;
  initial begin
    $dumpfile("spi_master_tb.vcd");
    $dumpvars(0, SPIMaster_tb);
    #32 $finish;
  end
  // Parameters
  parameter DATA_WIDTH = 8;
  parameter CLK_DIV_WIDTH = 8;

  // Testbench signals
  reg clk;
  reg reset;
  reg start;
  reg [DATA_WIDTH-1:0] data_in;
  wire sclk;
  wire mosi;
  reg miso;
  wire ss;
  wire [DATA_WIDTH-1:0] data_out;
  wire busy;

  // Instantiate the SPI Master module
  SPIMaster #(
    .DATA_WIDTH(DATA_WIDTH),
    .CLK_DIV_WIDTH(CLK_DIV_WIDTH)
  ) uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(data_in),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss),
    .data_out(data_out),
    .busy(busy)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period (100 MHz)
  end

  // Testbench logic
  initial begin
    // Initialize signals
    reset = 1;
    start = 0;
    data_in = 0;
    miso = 0;
    #20; // Wait for 20ns

    // Release reset
    reset = 0;
    #20; // Wait for 20ns

    // Start a transaction
    data_in = 8'hAB; // Data to transmit
    start = 1;
    #10; // Hold start for 10ns
    start = 0;

    // Simulate the slave response (slave sends 0x55)
    wait(busy == 1); // Wait for the master to start the transaction
    for (integer i = 0; i < DATA_WIDTH; i = i + 1) begin
      wait(sclk == 1); // Wait for SCLK to go high
      #5; // Wait for half a clock cycle
      miso = (8'h55 >> (DATA_WIDTH-1 - i)) & 1; // Simulate MISO input
      #5; // Wait for the other half of the clock cycle
    end

    // Wait for the transaction to complete
    wait(busy == 0);

    // Check the received data
    if (data_out == 8'h55) begin
      $display("Test passed: Received data matches expected value (0x55)!");
    end else begin
      $display("Test failed: Received data = 0x%h, Expected data = 0x55", data_out);
    end

    // End simulation
    #100;
    $finish;
  end
endmodule
