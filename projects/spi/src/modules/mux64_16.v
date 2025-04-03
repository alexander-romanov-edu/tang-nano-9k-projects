module mux64_16 (
    input [63:0] dat,
    output wire [15:0] out,
    input [1:0] adr
);
  assign out = f(adr, dat);

  function automatic [15:0] f(input reg [1:0] adr, input reg [63:0] dat);
    unique case (adr)
      0: f = dat[15:0];
      1: f = dat[31:16];
      2: f = dat[47:32];
      3: f = dat[63:48];
    endcase
  endfunction
endmodule
