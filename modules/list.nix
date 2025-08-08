{...}: {
  config.vim = {
    options = {
      list = true;
      cursorline = true;
      cursorlineopt = "both";
    };
    luaConfigRC.whitespace = ''
      vim.opt.listchars = {
        space = '·',      -- Show spaces as middle dot
        tab = '→ ',       -- Show tabs with arrow and spaces
        trail = '•',      -- Show trailing spaces as bullet
        nbsp = '␣',       -- Show non-breaking spaces
        extends = '⟩',     -- Show when line extends beyond screen
        precedes = '⟨',    -- Show when line precedes screen
      }
    '';
  };
}
