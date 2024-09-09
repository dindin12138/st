{
  description = "Flake for building and installing suckless st (simple terminal)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in
      {
        default = pkgs.stdenv.mkDerivation {
          pname = "st";
          version = "0.9.2";

          src = ./.;

          nativeBuildInputs = [
            pkgs.pkg-config
            pkgs.ncurses
            pkgs.fontconfig
            pkgs.freetype
          ];

          buildInputs = [
            pkgs.xorg.libX11
            pkgs.xorg.libXft
          ];

          patches = [
            # ./my-local-patch.patch
          ];

          makeFlags = [
            "PKG_CONFIG=${pkgs.stdenv.cc.targetPrefix}pkg-config"
          ];

          installFlags = [ "PREFIX=$(out)" ];

          preInstall = ''
            export TERMINFO=$out/share/terminfo
            mkdir -p $TERMINFO
          '';

          meta = {
            description = "Simple Terminal from suckless.org";
            license = pkgs.lib.licenses.mit;
            platforms = pkgs.lib.platforms.unix;
          };
        };
      };
  };
}
