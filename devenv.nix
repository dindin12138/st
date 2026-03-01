{ pkgs, ... }:
{
  languages.cplusplus.enable = true;
  packages = with pkgs; [
    gnumake
    ninja
    pkg-config
    bear
    lldb
    ncurses
    fontconfig
    freetype
    expat
    xorg.libX11
    xorg.libXft
    harfbuzz
  ];
  env.CC = "clang";
  enterShell = ''
    echo "🚀 Entered st (suckless terminal) development environment."
    echo "📦 Compiler: $(clang --version | head -n 1)"
    echo "🛠  Make: $(make --version | head -n 1)"
  '';
}
