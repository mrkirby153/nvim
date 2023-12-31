{pkgs}: let
  customRC = import ../cfg {inherit pkgs;};
  plugins = import ../cfg/plugins.nix {inherit pkgs;};
  extraPackages = import ./extraPkgs.nix { inherit pkgs; };

  neovim-config = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins;
    inherit customRC;
    withPython3 = true;
    withNodeJs = true;
    extraPython3Packages = ps: with ps; [python-lsp-server];
    extraLuaPackages = ps: with ps; [cjson];
  };

  extraWrapperArgs = builtins.concatStringsSep " " (pkgs.lib.optional (extraPackages != []) ''--prefix PATH : "${pkgs.lib.makeBinPath extraPackages}"'');
in
  pkgs.wrapNeovimUnstable pkgs.neovim (neovim-config
    // {
      extraName = "-kirby";
      vimAlias = true;
      viAlias = true;
      wrapperArgs = pkgs.lib.escapeShellArgs neovim-config.wrapperArgs + " " + extraWrapperArgs;
    })
