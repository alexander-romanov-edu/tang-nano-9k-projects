module spi_slave #(
    parameter int WIDTH = 13
) (
    input load,
    output wire miso,
    input sclk,
    input mosi,
    input clr,
    output reg [WIDTH-1:0] sr_stx = 0,
    output reg [WIDTH-1:0] sr_srx = 0,
    output reg [WIDTH-1:0] dout = 0,
    input [WIDTH-1:0] din
);
  wire clk1;
  wire clk2;

`ifdef CLKFREQ
  BUFG dd1 (
      .I(sclk),
      .O(clk1)
  );
  BUFG dd2 (
      .I(load),
      .O(clk2)
  );
`else
  assign clk1 = sclk;
  assign clk2 = load;
`endif

  assign miso = sr_stx[WIDTH-1];
  always @(posedge sclk) begin
    sr_srx <= sr_srx << 1 | mosi;
  end

  always @(posedge clk2 or posedge clr) begin
    dout <= clr ? 0 : sr_srx;
  end

  always @(posedge load or negedge clk1) begin
    sr_stx <= load ? din : sr_stx << 1;
  end
endmodule

