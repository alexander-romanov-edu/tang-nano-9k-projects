module SPIMaster #(
  parameter DATA_WIDTH = 8,  // Data width (default is 8 bits)
  parameter CLK_DIV_WIDTH = 8 // Clock divider width (default is 8 bits)
)(
  input wire clk,            // System clock
  input wire reset,          // Asynchronous reset
  input wire start,          // Start signal to initiate SPI transaction
  input wire [DATA_WIDTH-1:0] data_in, // Data to transmit
  output wire sclk,          // SPI clock
  output wire mosi,          // Master Out Slave In (data line)
  input wire miso,           // Master In Slave Out (data line)
  output wire ss,            // Slave Select (active low)
  output wire [DATA_WIDTH-1:0] data_out, // Received data from slave
  output wire busy           // Busy signal (high during transaction)
);

  // Internal registers and wires
  reg [CLK_DIV_WIDTH-1:0] clk_div;      // Clock divider counter
  reg [DATA_WIDTH-1:0] shift_reg_rx;    // Shift register for received data
  reg [DATA_WIDTH-1:0] bit_counter;     // Bit counter
  reg sclk_reg;                         // SCLK register
  reg load_reg;                         // Load register
  reg busy_reg;                         // Busy register

  // Clock divider logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      clk_div <= 0;
      sclk_reg <= 0;
    end else begin
      if (clk_div == (CLK_DIV_WIDTH-1)) begin
        clk_div <= 0;
        sclk_reg <= ~sclk_reg; // Toggle SCLK
      end else begin
        clk_div <= clk_div + 1;
      end
    end
  end

  // Assign SCLK output
  assign sclk = sclk_reg;

  // Bit counter logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      bit_counter <= 0;
      busy_reg <= 0;
      load_reg <= 0;
    end else if (start && !busy_reg) begin
      bit_counter <= 0;
      busy_reg <= 1;
      load_reg <= 1;
    end else if (busy_reg) begin
      if (sclk_reg && clk_div == 0) begin
        if (bit_counter == (DATA_WIDTH-1)) begin
          busy_reg <= 0;
        end else begin
          bit_counter <= bit_counter + 1;
        end
      end
      load_reg <= 0;
    end
  end

  // Shift register for transmitted data
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_reg_rx <= 0;
    end else if (load_reg) begin
      shift_reg_rx <= data_in; // Load data to transmit
    end else if (sclk_reg && clk_div == 0 && busy_reg) begin
      shift_reg_rx <= {shift_reg_tx[DATA_WIDTH-2:0], 1'b0}; // Shift out data
    end
  end

  // Shift register for received data
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_reg_rx <= 0;
    end else if (!sclk_reg && clk_div == 0 && busy_reg) begin
      shift_reg_rx <= {shift_reg_rx[DATA_WIDTH-2:0], miso}; // Shift in data
    end
  end

  // Assign outputs
  assign mosi = shift_reg_rx[DATA_WIDTH-1]; // Transmit MSB first
  reg [DATA_WIDTH-1:0] shift_reg_tx;    // Shift register for transmitted data
  assign ss = ~busy_reg; // Slave Select is active low
  assign data_out = shift_reg_rx; // Received data
  assign busy = busy_reg; // Busy signal
endmodule
