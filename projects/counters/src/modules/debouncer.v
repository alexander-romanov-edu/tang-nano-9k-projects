module debouncer (
    input clk,
    input ce1ms,
    input btn_in,
    output reg btn_out
);
  reg q1 = 0;
  reg q2 = 0;

  always @(posedge clk) begin
    if (ce1ms) begin
      q1 <= btn_in;
      q2 <= q1;
    end
  end

  assign btn_out = q1 & ~q2 & ce1ms;
endmodule
