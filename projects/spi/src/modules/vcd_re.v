module vcd_re (
    input ce,
    input clk,
    input rst,
    output reg [3:0] q = 0,
    output wire tc,
    output wire ceo
);
  assign tc  = (q == 9);
  assign ceo = ce & tc;
  always @(posedge clk) begin
    q <= (rst | ceo) ? 0 : (ce ? q + 1 : q);
  end
endmodule
