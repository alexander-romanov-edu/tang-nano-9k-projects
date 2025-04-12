module gen_p (
    input [1:0] ptr,
    output wire seg_p,
    input [1:0] adr_an
);
  assign seg_p = (ptr == adr_an);
endmodule
