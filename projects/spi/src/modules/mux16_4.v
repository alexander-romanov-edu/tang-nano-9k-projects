module mux16_4 (
    input [15:0] dat,
    output wire [3:0] digit_output,
    input [1:0] adr
);
  assign digit_output = f(adr, dat);

  function automatic [3:0] f(input reg [1:0] adr, input reg [15:0] dat);
    unique case (adr)
      0: f = dat[3:0];
      1: f = dat[7:4];
      2: f = dat[11:8];
      3: f = dat[15:12];
    endcase
  endfunction
endmodule
