module SPISlave #(
  parameter DATA_WIDTH = 8 // Data width (default is 8 bits)
)(
  input wire clk,          // System clock (used for internal logic)
  input wire sclk,         // SPI clock from the master
  input wire mosi,         // Master Out Slave In (data line from master)
  output reg miso,         // Master In Slave Out (data line to master)
  input wire ss,           // Slave Select (active low)
  input wire [DATA_WIDTH-1:0] data_in, // Data to send to the master
  output reg [DATA_WIDTH-1:0] data_out // Data received from the master
);

  // Internal registers
  reg [DATA_WIDTH-1:0] shift_reg_rx; // Shift register for received data
  reg [DATA_WIDTH-1:0] bit_counter;  // Bit counter

  // Initialize registers
  initial begin
    shift_reg_rx = 0;
    shift_reg_rx = 0;
    bit_counter = 0;
    miso = 0;
    data_out = 0;
  end

  // SPI Slave logic
  always @(negedge sclk or posedge ss) begin
    if (ss) begin
      // Slave is not selected, reset internal state
      bit_counter <= 0;
      shift_reg_rx <= 0;
      miso <= 0;
    end else begin
      // Slave is selected, process data
      if (bit_counter < DATA_WIDTH) begin
        // Shift in data from MOSI
        shift_reg_rx <= {shift_reg_rx[DATA_WIDTH-2:0], mosi};

        // Shift out data on MISO
        miso <= shift_reg_rx[DATA_WIDTH-1];
        shift_reg_rx <= {shift_reg_rx[DATA_WIDTH-2:0], 1'b0};

        // Increment bit counter
        bit_counter <= bit_counter + 1;
      end else begin
        // Transaction complete, latch received data
        data_out <= shift_reg_rx;
      end
    end
  end

  // Load data to transmit when Slave Select is asserted
  always @(posedge ss) begin
    if (!ss) begin
      shift_reg_rx <= data_in; // Load data to transmit
    end
  end
endmodule
