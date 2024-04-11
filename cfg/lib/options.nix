{
  lib,
  config,
  pkgs,
  ...
}: let

  extraTypes = import ./types.nix { inherit lib; };

  rcModuleType = lib.types.submodule {
    options = {
      vimscript = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        default = [];
      };
      lua = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        default = [];
      };
    };
  };

  aliasType = lib.types.submodule {
    options = {
      vim = lib.mkEnableOption {
        default = false;
      };
      vi = lib.mkEnableOption {
        default = false;
      };
    };
  };

  vimCfg = config.nvim;
in {
  options.nvim = {
    alias = lib.mkOption {
      type = aliasType;
      default = {
        vim = true;
        vi = true;
      };
    };

    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
    };

    extraConfigFiles = lib.mkOption {
      type = rcModuleType;
      default = {
        vimscript = [];
        lua = [];
      };
    };
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
    };

    extraPython3Packages = lib.mkOption {
      type =  extraTypes.lambdaList;
      default = ps: [];
    };

    extraLuaPackages = lib.mkOption {
      type =  extraTypes.lambdaList;
      default = ps: [];
    };

    extraName = lib.mkOption {
      type = lib.types.str;
      default = "-kirby";
    };

    # The output package
    pkg = lib.mkOption {
      type = lib.types.package;
    };
  };

  config = {
    nvim.pkg = (
      let
        neovim-config = pkgs.neovimUtils.makeNeovimConfig {
          plugins = vimCfg.plugins;
          customRC = ''
            let configdir = "${../extra}"
            let runtimepath_list = split(&runtimepath, ',')
            call insert(runtimepath_list, configdir, 0)
            let &runtimepath = join(runtimepath_list, ',')
            let &packpath = &runtimepath

            ${builtins.concatStringsSep "\n" (builtins.map (f: "source ${f}") vimCfg.extraConfigFiles.vimscript)}
            ${builtins.concatStringsSep "\n" (builtins.map (f: "luafile ${f}") vimCfg.extraConfigFiles.lua)}
            ${vimCfg.extraConfig}
          '';
          withPython3 = true;
          withNodeJs = true;
          extraPython3Packages = 
          ps:
            lib.concatLists (builtins.map (func: func(ps)) vimCfg.extraPython3Packages);
          extraLuaPackages =
          ps:
            lib.concatLists (builtins.map (func: func(ps)) vimCfg.extraLuaPackages);
        };

        extraWrapperArgs = builtins.concatStringsSep " " (pkgs.lib.optional (vimCfg.extraPackages != []) ''--prefix PATH : "${pkgs.lib.makeBinPath vimCfg.extraPackages}"'');
      in
        pkgs.wrapNeovimUnstable pkgs.neovim (neovim-config
          // {
            extraName = vimCfg.extraName;
            vimAlias = vimCfg.alias.vim;
            viAlias = vimCfg.alias.vi;
            wrapperArgs = pkgs.lib.escapeShellArgs neovim-config.wrapperArgs + " " + extraWrapperArgs;
          })
    );
  };
}
