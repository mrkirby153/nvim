{pkgs}: let
  customRC = import ../cfg {inherit pkgs;};
  plugins = import ../cfg/plugins.nix {inherit pkgs;};
in
  pkgs.wrapNeovim pkgs.neovim {
    configure = {
      inherit customRC;
      packages.all.start = plugins;
    };
  }
