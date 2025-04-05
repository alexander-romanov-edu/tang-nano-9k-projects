module spi_slave #(
    parameter int WIDTH = 13
) (
    input load,
    output wire miso,
    input sclk,
    input mosi,
    input clr,
    output reg [WIDTH-1:0] sr_stx,
    output reg [WIDTH-1:0] sr_srx = 0,
    output reg [WIDTH-1:0] dout = 0,
    input [WIDTH-1:0] din
);
  assign miso = sr_stx[WIDTH-1];

  always @(posedge load) begin
    dout <= sr_srx;
  end

  always @(posedge sclk) begin
    sr_srx <= sr_srx << 1 | mosi;
  end

  always @(negedge sclk or posedge load) begin
    if (load) sr_stx <= din;
    else if (clr) sr_stx = 0;
    else sr_stx <= sr_stx << 1;
  end
endmodule

