module gen4an (
    input ce,
    input clk,
    output reg [1:0] q = 0,
    output wire [3:0] an
);
  assign an = (4'b0001 << q);

  always @(posedge clk)
    if (ce) begin
      q <= q + 1;
    end
endmodule
