{
  description = "My Neovim Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "flake-utils";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    telescope-recent-files-src = {
      url = "github:smartpde/telescope-recent-files";
      flake = false;
    };
    vaffle-src = {
      url = "github:cocopon/vaffle.vim";
      flake = false;
    };
    css3-syntax-src = {
      url = "github:hail2u/vim-css3-syntax";
      flake = false;
    };
    coloresque-src = {
      url = "github:gko/vim-coloresque";
      flake = false;
    };
    haml-src = {
      url = "github:tpope/vim-haml";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim,
    telescope-recent-files-src,
    vaffle-src,
    css3-syntax-src,
    coloresque-src,
    haml-src,
    ...
  } @ inputs: let
    overlayNvim = final: prev: {
      kirby-nvim = import ./pkg/nvim.nix {
        pkgs = final;
      };
    };
  in
    flake-utils.lib.eachDefaultSystem (system: let
      overlayFlakeInputs = final: prev: let
        buildVimPlugin = {
          name,
          src,
          ...
        } @ buildVimPluginInputs:
          pkgs.vimUtils.buildVimPlugin buildVimPluginInputs;
      in {
        neovim = inputs.neovim.packages.${final.system}.neovim;

        vimPlugins =
          prev.vimPlugins
          // {
            telescope-recent-files = buildVimPlugin {
              name = "telescope-recent-files";
              src = telescope-recent-files-src;
            };
            vaffle = buildVimPlugin {
              name = "vaffle";
              src = vaffle-src;
            };
            css3-syntax = buildVimPlugin {
              name = "css3-syntax";
              src = css3-syntax-src;
            };
            coloresque = buildVimPlugin {
              name = "coloresque";
              src = coloresque-src;
            };
            haml = buildVimPlugin {
              name = "haml";
              src = haml-src;
            };
          };
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [overlayFlakeInputs overlayNvim];
      };
    in {
      formatter = pkgs.alejandra;
      packages = rec {
        default = pkgs.kirby-nvim;
        neovim = default;
      };
      apps = rec {
        default = {
          type = "app";
          program = "${pkgs.kirby-nvim}/bin/nvim";
        };
        neovim = default;
      };
    })
    // {
      overlays.default = overlayNvim;
    };
}
