{pkgs, ...}: {
  imports = [
    ./plugins.nix
  ];

  config.nvim = {
    extraConfigFiles = {
      lua = [
        ./lua/01-init.lua
        ./lua/autocmd.lua
        ./lua/cmp.lua
        ./lua/gitsigns.lua
        ./lua/keymap.lua
        ./lua/lualine.lua
        ./lua/nvim-config-local.lua
        ./lua/nvim-lspconfig.lua
        ./lua/nvim-telescope.lua
        ./lua/treesitter.lua
        ./lua/trouble.lua
        ./lua/fidget.lua
      ];
      vimscript = [
        ./vimscript/annoyances.vim
      ];
    };
    extraPython3Packages = ps:
      with ps; [
        python-lsp-server
      ];
    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      lua-language-server
    ];
  };
}
