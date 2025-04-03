module spi_master #(
    parameter int CLKFREQ = 27000000,  // 27MHz
    parameter int WIDTH = 13,
    parameter int SPIFREQ = 100000  // 100KHz = 10us
) (
    input st,
    input clk,

    output reg sclk = 0,
    output reg load = 1,
    output wire mosi,
    input miso,

    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout = 0,
    input clr,
    output reg [WIDTH-1:0] sr_mtx = 0,
    output reg [WIDTH-1:0] sr_mrx = 0,
    output reg [7:0] cb_bit = 0,
    output wire ce,
    output wire ce_tact
);
  localparam int NT = CLKFREQ / (2 * SPIFREQ);

  reg [8:0] cb_tact = 0;

  assign ce = (cb_tact == NT - 1);
  assign mosi = sr_mtx[WIDTH-1];
  assign ce_tact = ce & sclk;

  wire start = st & load;

  always @(posedge clk) begin
    load <= st ? 0 : ((cb_bit == WIDTH - 1) & ce_tact) ? 1 : load;
    cb_tact <= (start | ce) ? 0 : cb_tact + 1;
    sclk <= load ? 0 : ce ? !sclk : sclk;
    sr_mtx <= start ? din : ce_tact ? sr_mtx << 1 : sr_mtx;
    cb_bit <= start ? 0 : ce_tact ? cb_bit + 1 : cb_bit;
  end

  always @(posedge sclk) begin
    sr_mrx <= sr_mrx << 1 | miso;
  end

  always @(posedge load or posedge clr) begin
    dout <= clr ? 0 : sr_mrx;
  end
endmodule
