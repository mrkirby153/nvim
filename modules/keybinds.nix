{...}: let
  modes = {
    all = [];
    normal = "n";
    visual = ["v" "s"];
    insert = "i";
    terminal = "t";
  };
in {
  config.vim = {
    keymaps = [
      # Navigate windows with ctrl + shift + hjkl
      {
        key = "<C-J>";
        mode = modes.all;
        action = "<C-W>j";
      }
      {
        key = "<C-K>";
        mode = modes.all;
        action = "<C-W>k";
      }
      {
        key = "<C-H>";
        mode = modes.all;
        action = "<C-W>h";
      }
      {
        key = "<C-L>";
        mode = modes.all;
        action = "<C-W>l";
      }

      # Alt + H to unhighlight
      {
        key = "<A-h>";
        mode = modes.all;
        action = ":noh<CR>";
        silent = true;
      }

      # Stay in visual mode after indenting
      {
        key = "<";
        mode = modes.visual;
        action = "<gv";
      }
      {
        key = ">";
        mode = modes.visual;
        action = ">gv";
      }

      # No-op stupid commands
      {
        key = "q:";
        mode = modes.normal;
        action = "<nop>";
      }
      {
        key = "Q";
        mode = modes.normal;
        action = "<nop>";
      }

      # Sorting
      {
        key = "<C-R>a";
        mode = modes.all;
        silent = true;
        action = ":sort<CR>";
      }
      {
        key = "<C-R>d";
        mode = modes.all;
        silent = true;
        action = ":sort!<CR>";
      }
    ];
  };
}
