require('trouble').setup{
    height = 20
}

vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)