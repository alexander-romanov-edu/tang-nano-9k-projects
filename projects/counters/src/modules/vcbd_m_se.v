module vcbd_m_se #(
    parameter int WIDTH = 4
) (
    input ce,
    input clk,
    input rst,
    output reg [WIDTH-1:0] q = (1 << WIDTH) - 1,
    output wire tc,
    output wire ceo
);
  assign tc  = (q == 0);
  assign ceo = ce & tc;

  wire max = ((1 << WIDTH) - 1);

  always @(posedge clk) begin
    q <= rst ? max : (ce ? q - 1 : q);
  end
endmodule
