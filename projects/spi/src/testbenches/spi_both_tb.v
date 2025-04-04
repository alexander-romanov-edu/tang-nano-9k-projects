module spi_both_tb;
  localparam int WIDTH = 13;

  reg clk;
  reg st;
  reg load;
  reg [WIDTH-1:0] mtx_dat;
  reg [WIDTH-1:0] stx_dat;
  reg rst;

  wire mosi;
  wire miso;
  wire sclk;

  initial begin
    $dumpfile("spi_both_tb.vcd");
    $dumpvars(0, spi_both_tb);

    st = 0;
    rst = 0;
    stx_dat = 0;
    mtx_dat = 0;
    #26;

    st = 1;
    #2;

    mtx_dat = 13'b1001001001001;
    stx_dat = 13'b0101001011001;
    st = 0;
    #128;

    st = 1;
    #2;
    st = 0;

    #128;

    st  = 1;
    rst = 0;

    #2;

    st = 0;

    #128;

    $finish;
  end

  always begin
    clk = 1;
    #1;
    clk = 0;
    #1;
  end

  spi_test_slave #(
      .WIDTH  (WIDTH),
      .CLKFREQ(8),
      .SPIFREQ(2)
  ) master (
      .st(st),
      .clk(clk),
      .rst(rst),
      .mtx_dat(mtx_dat),
      .stx_dat(stx_dat),
      .mosi(mosi),
      .miso(miso),
      .sclk(sclk),
      .load(load)
  );
endmodule
