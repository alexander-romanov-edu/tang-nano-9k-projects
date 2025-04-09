{
  stdenvNoCC,
  lib,
  yosys,
  nextpnr,
  iverilog,
  yosys-synlig,
  python3Packages,
}:
stdenvNoCC.mkDerivation {
  pname = "tangnano9k-spi";
  version = "0";

  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    yosys
    nextpnr
    iverilog
    python3Packages.apycula
    yosys-synlig
  ];

  installPhase = ''
    cp -r build $out
  '';
}
