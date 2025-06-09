{pkgs, ...}: {
  config.vim = {
    startPlugins = with pkgs.vimPlugins; [
      neovim-ayu
      lazygit-nvim
    ];
    lazy.plugins = with pkgs.vimPlugins; {
      # Color Scheme
      neovim-ayu = {
        package = neovim-ayu;
        setupModule = "ayu";
        setupOpts = {
          mirage = true;
        };
        after = ''
          require('ayu').colorscheme()
        '';
      };
      "lazygit.nvim" = {
        package = lazygit-nvim;
        keys = [
          {
            key = "<leader>gg";
            mode = "n";
            action = ":LazyGit<CR>";
            desc = "Open LazyGit";
            silent = true;
          }
        ];
      };
    };
  };
}
