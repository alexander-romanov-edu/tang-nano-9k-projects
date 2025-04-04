module vcb_m_re #(
    parameter int WIDTH = 4
) (
    input ce,
    input clk,
    input rst,
    output reg [WIDTH-1:0] q = 0,
    output wire tc,
    output wire ceo
);
  assign tc  = (q == (1 << WIDTH) - 1);
  assign ceo = ce & tc;
  always @(posedge clk) begin
    q <= rst ? 0 : (ce ? q + 1 : q);
  end
endmodule
