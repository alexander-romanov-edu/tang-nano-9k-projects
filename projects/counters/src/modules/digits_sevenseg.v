module digits_sevenseg (
    input [3:0] dig,
    output wire [6:0] seg
);
  function automatic [6:0] f(input reg [3:0] dig);
    case (dig)
      0:  f = 7'h3f;
      1:  f = 7'h06;
      2:  f = 7'h5b;
      3:  f = 7'h4f;
      4:  f = 7'h66;
      5:  f = 7'h6d;
      6:  f = 7'h7d;
      7:  f = 7'h07;
      8:  f = 7'h7f;
      9:  f = 7'h67;
      10: f = 7'h77;
      11: f = 7'h7c;
      12: f = 7'h39;
      13: f = 7'h5e;
      14: f = 7'h79;
      15: f = 7'h71;
    endcase
  endfunction

  assign seg = f(dig);
endmodule
