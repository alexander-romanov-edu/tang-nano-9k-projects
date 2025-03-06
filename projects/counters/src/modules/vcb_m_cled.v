module vcb_m_cled #(
    parameter int WIDTH = 4
) (
    input ce,
    input up,
    input [WIDTH-1:0] di,
    input l,
    input clk,
    input clr,
    output reg [WIDTH-1:0] q = 0,
    output wire tc,
    output wire ceo
);
  wire max = (1 << WIDTH) - 1;

  assign tc  = up ? (q == max) : (q == 0);
  assign ceo = ce & tc;

  always @(posedge clr or posedge clk) begin
    if (clr) q <= 0;
    else q <= l ? di : ((up & ce) ? q + 1 : ((!up & ce) ? q - 1 : q));
  end
endmodule
