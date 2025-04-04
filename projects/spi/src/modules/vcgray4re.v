module vcgray4re (
    input ce,
    input clk,
    input rst,
    output wire [3:0] y,
    output wire ceo,
    output wire tc
);
  reg [4:0] q = 0;

  assign tc  = (q[4:0] == ((1 << 4) | 1));
  assign ceo = ce & tc;
  assign y   = q[4:1];

  always @(posedge clk) begin
    q[0] <= (rst | ceo) ? 0 : ce ? !q[0] : q[0];
    q[1] <= (rst | ceo) ? 0 : ((q[0] == 0) & ce) ? !q[1] : q[1];
    q[2] <= (rst | ceo) ? 0 : ((q[1:0] == ((1 << 1) | 1)) & ce) ? !q[2] : q[2];
    q[3] <= (rst | ceo) ? 0 : ((q[2:0] == ((1 << 2) | 1)) & ce) ? !q[3] : q[3];
    q[4] <= (rst | ceo) ? 0 : ((q[3:0] == ((1 << 3) | 1)) & ce) ? !q[4] : q[4];
  end
endmodule
