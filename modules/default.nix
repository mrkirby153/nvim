{...}: {
  imports = [
    ./keybinds.nix
    ./list.nix
    ./plugins.nix
  ];
  config.vim = {
    options = {
      cursorline = true;
      cursorlineopt = "both";
    };
    visuals = {
      fidget-nvim.enable = true;
      highlight-undo.enable = true;
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
      nvim-cursorline.enable = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      trouble.enable = true;
      lightbulb.enable = true;
      lspkind.enable = true;
    };
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # sort-lines: on
      assembly.enable = true;
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      nix.enable = true;
      rust.crates.enable = true;
      rust.enable = true;
      ts.enable = true;
      zig.enable = true;
      markdown.enable = true;
      # sort-lines: off

      nix.format.type = "nixfmt"; # looks so much nicer
    };
    filetree.neo-tree.enable = true;
    autocomplete = {
      blink-cmp = {
        enable = true;
        sourcePlugins = {
          ripgrep.enable = true;
        };
      };
    };
    statusline = {
      lualine = {
        enable = true;
        refresh = {
          statusline = 100;
          tabline = 100;
          winbar = 100;
        };
      };
    };
    git.enable = true;
  };
}
