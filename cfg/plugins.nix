{pkgs, ...}: let
  # TODO (2024-07-05): The 2024-07-03 plugin pulled in by nixpkgs-unstable has a bug that prevnets the plugin from working.
  # This was fixed in https://github.com/godlygeek/tabular/commit/12437cd1b53488e24936ec4b091c9324cafee311 but is not updated
  # in nixpkgs.
  tabular-custom = pkgs.vimPlugins.tabular.overrideAttrs (oldAttrs: {
    version = "2024-07-05";
    src = pkgs.fetchFromGitHub {
      owner = "godlygeek";
      repo = "tabular";
      rev = "12437cd1b53488e24936ec4b091c9324cafee311";
      sha256 = "sha256-qmDpdg3Tl3W4JSovRb4ODlrKMjRL5CaVI05YBn0Q0LI=";
    };
  });
in {
  config.nvim.plugins = with pkgs.vimPlugins; [
    cmp-nvim-lsp
    coloresque
    conflict-marker-vim
    css3-syntax
    emmet-vim
    fidget-nvim
    gitsigns-nvim
    haml
    lazygit-nvim
    lualine-nvim
    luasnip
    mason-lspconfig-nvim
    mason-nvim
    neo-tree-nvim
    neosnippet
    neosnippet-snippets
    neovim-ayu
    nerdcommenter
    nvim-cmp
    nvim-config-local
    nvim-lspconfig
    nvim-treesitter-textobjects
    nvim-treesitter.withAllGrammars
    nvim-web-devicons
    python-mode
    rainbow
    syntastic
    tabular-custom
    tagbar
    telescope-nvim
    telescope-recent-files
    trouble-nvim
    typescript-vim
    vaffle
    vim-closetag
    vim-commentary
    vim-fugitive
    vim-gist
    vim-highlightedyank
    vim-javascript
    vim-json
    vim-jsx-pretty
    vim-jsx-typescript
    vim-markdown
    vim-matchup
    vim-repeat
    vim-snippets
    vim-surround
    vim-toml
    webapi-vim
  ];
}
