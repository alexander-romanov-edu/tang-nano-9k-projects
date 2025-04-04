module SPIMasterSlaveTop #(
  parameter DATA_WIDTH = 8 // Data width (default is 8 bits)
)(
  input wire clk,          // System clock
  input wire reset,        // Asynchronous reset
  input wire start         // Start signal to initiate SPI transaction
);

  // Internal signals
  wire sclk;               // SPI clock
  wire mosi;               // Master Out Slave In
  wire miso;               // Master In Slave Out
  wire ss;                 // Slave Select
  wire [DATA_WIDTH-1:0] master_data_out; // Data received by master
  wire [DATA_WIDTH-1:0] slave_data_out;  // Data received by slave
  reg [DATA_WIDTH-1:0] master_data_in;   // Data to transmit from master
  reg [DATA_WIDTH-1:0] slave_data_in;    // Data to transmit from slave

  // Instantiate the SPI Master module
  SPIMaster #(
    .DATA_WIDTH(DATA_WIDTH)
  ) master (
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(master_data_in),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss),
    .data_out(master_data_out),
    .busy()
  );

  // Instantiate the SPI Slave module
  SPISlave #(
    .DATA_WIDTH(DATA_WIDTH)
  ) slave (
    .clk(clk),
    .sclk(sclk),
    .mosi(mosi),
    .miso(miso),
    .ss(ss),
    .data_in(master_data_out),
    .data_out(slave_data_out)
  );
// Initialize data to transmit
  initial begin
    master_data_in = 8'hAB; // Data to transmit from master
    slave_data_in = 8'h55;  // Data to transmit from slave
  end
endmodule
