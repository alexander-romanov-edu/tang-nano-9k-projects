// https://en.wikipedia.org/wiki/Double_dabble

module bin2bcd #(
    parameter int WIDTH = 16
) (
    input      [        WIDTH-1 : 0] bin,
    output reg [WIDTH+(WIDTH-4)/3:0] bcd
);
  integer i, j;

  always @(bin) begin
    for (i = 0; i <= WIDTH + (WIDTH - 4) / 3; i = i + 1) bcd[i] = 0;
    bcd[WIDTH-1:0] = bin;
    for (i = 0; i <= WIDTH - 4; i = i + 1)
    for (j = 0; j <= i / 3; j = j + 1)
    if (bcd[WIDTH-i+4*j-:4] > 4) bcd[WIDTH-i+4*j-:4] = bcd[WIDTH-i+4*j-:4] + 4'd3;
  end

endmodule
