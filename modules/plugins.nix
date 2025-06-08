{pkgs, ...}: {
  config.vim = {
    startPlugins = with pkgs.vimPlugins; [
      neovim-ayu
    ];
    lazy.plugins = {
      neovim-ayu = {
        package = pkgs.vimPlugins.neovim-ayu;
        setupModule = "ayu";
        setupOpts = {
          mirage = true;
        };
        after = ''
          require('ayu').colorscheme()
        '';
      };
    };
  };
}
