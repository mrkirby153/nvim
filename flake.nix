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
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim,
    telescope-recent-files-src,
    ...
  } @ inputs:
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
          };
      };
      overlayNvim = final: prev: {
        aus = {
          nvim = import ./pkg/nvim.nix {
            pkgs = final;
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
        default = pkgs.aus.nvim;
        neovim = default;
      };
      apps = rec {
        default = {
          type = "app";
          program = "${pkgs.aus.nvim}/bin/nvim";
        };
        neovim = default;
      };
    })
    // {
      overlays.default = self.overlayNvim;
    };
}
