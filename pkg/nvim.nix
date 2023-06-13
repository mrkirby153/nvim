{pkgs}: let
  customRC = import ../cfg {inherit pkgs;};
  plugins = import ../cfg/plugins.nix {inherit pkgs;};
  neovim-config = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins;
    inherit customRC;
    withPython3 = true;
    withNodeJs = true;

    extraPython3Packages = ps: with ps; [python-lsp-server];
  };
in
  pkgs.wrapNeovimUnstable pkgs.neovim (neovim-config
    // {
      extraName = "-kirby";
      vimAlias = true;
      viAlias = true;
    })
