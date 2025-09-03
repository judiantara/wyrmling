{ pkgs }:

# https://github.com/sayyadirfanali/Myna
pkgs.stdenv.mkDerivation {
  pname = "myna-font";
  version = "1.0.0";

  src = ./Myna-v1.0.0.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 *.otf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
