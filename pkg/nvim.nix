{pkgs}: let
  customRC = import ../cfg {inherit pkgs;};
  plugins = import ../cfg/plugins.nix {inherit pkgs;};
  myNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      inherit customRC;
      packages.all.start = plugins;
    };
  };
in
  pkgs.writeShellApplication {
    name = "nvim";
    runtimeInputs = [];
    text = ''
      ${myNeovim}/bin/nvim "$@"
    '';
  }
