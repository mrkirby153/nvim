{
  description = "My Neovim Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "flake-utils";
    nvf.url = "github:notashelf/nvf";

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
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    inlay-hints-nvim = {
      url = "github:MysticalDevil/inlay-hints.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nvf,
    telescope-recent-files-src,
    vaffle-src,
    css3-syntax-src,
    coloresque-src,
    haml-src,
    cmp-nvim-lsp,
    inlay-hints-nvim,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        packages = rec {
          nvim =
            (inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [
                ./modules
              ];
            }).neovim;
          default = nvim;
        };
        formatter = pkgs.alejandra;
      }
    );
}
