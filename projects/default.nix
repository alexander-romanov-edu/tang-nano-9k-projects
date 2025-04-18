{ pkgs, ... }:
{
  packages = {
    blinky = pkgs.callPackage ./blinky { };
    blinkygen-chisel = pkgs.callPackage ./chisel-blinky { };
    chisel-blinky = pkgs.callPackage ./chisel-blinky { };
    chisel-practice = pkgs.callPackage ./chisel-practice { };
    counters = pkgs.callPackage ./counters { };
    spi = pkgs.callPackage ./spi { };
  };
}
