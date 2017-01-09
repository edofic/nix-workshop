let

  pkgs = import <nixpkgs> {};

in

  pkgs.stdenv.mkDerivation {
    name = "example3";
    src = ./.;
    buildInputs = with pkgs; [ which tree ];
  }
