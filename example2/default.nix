let

  pkgs = import <nixpkgs> {};

in

  pkgs.stdenv.mkDerivation {
    name = "example2";
    src = ./.;
    buildCommand = ''
      mkdir -p $out/bin
      cp $src/example2.sh $out/bin/
      chmod +x $out/bin/example2.sh
    '';
  }
