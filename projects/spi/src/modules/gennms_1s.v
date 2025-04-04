module gennms_1s #(
    parameter int N = 25
) (
    input ce,
    input clk,
    output wire ceo,
    input tmod
);
  localparam int FKHZ = 1000;
  localparam int FHZ = 1;

  reg  [9:0] cb_n_ms = 0;
  wire [9:0] n_ms = tmod ? N - 1 : ((FKHZ / FHZ) - 1);

  assign ceo = ce & (cb_n_ms == 0);
  always @(posedge clk)
    if (ce) begin
      cb_n_ms <= (cb_n_ms == 0) ? n_ms : cb_n_ms - 1;
    end
endmodule
