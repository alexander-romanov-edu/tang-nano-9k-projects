module gen1ms #(
    parameter int CLKFREQ = 27000000
) (
    input clk,
    output wire ce1ms
);
  localparam int MAXCNTVAL = CLKFREQ / 1000;
  reg [15:0] cb_ms = MAXCNTVAL;
  assign ce1ms = (cb_ms == 1);

  always @(posedge clk) begin
    cb_ms <= ce1ms ? MAXCNTVAL : cb_ms - 1;
  end
endmodule
