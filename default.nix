{
  pkgs ? import <nixpkgs> {}
}:

let coq = import (fetchTarball https://github.com/coq/coq-on-cachix/tarball/master) {}; in

pkgs.stdenv.mkDerivation {
  name = "coq-stdlib2-0.0.0";
  buildInputs = [ coq ];
  src = ./src;
  configurePhase = "./bootstrap";

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}";

  meta = {
    inherit (coq.meta) homepage platforms license;
  };
}
