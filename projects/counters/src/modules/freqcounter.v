module freqcounter #(
    parameter int WIDTH = 16
) (
    input ce,
    input clk,
    input ovf,
    output reg [WIDTH-1:0] freq = 0
);
  reg [WIDTH-1:0] cnt = 0;

  always @(posedge clk) begin
    if (ce) begin
      cnt <= ovf ? 0 : cnt + 1;
      if (ovf) begin
        freq <= cnt + 1;
      end
    end
  end
endmodule
