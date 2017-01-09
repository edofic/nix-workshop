let

  pkgs = import <nixpkgs> {};

in

  pkgs.stdenv.mkDerivation {
    name = "example1";
    srcs = [];
    buildCommand = ''
      echo "Hello World" > $out
    '';
  }
