{
  stdenvNoCC,
  lib,
  yosys,
  nextpnr,
  iverilog,
  python3Packages,
}:
stdenvNoCC.mkDerivation {
  pname = "tangnano9k-counters";
  version = "0";

  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    yosys
    nextpnr
    iverilog
    python3Packages.apycula
  ];

  installPhase = ''
    cp -r build $out
  '';
}
