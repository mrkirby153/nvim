vim.defer_fn(function()
    require("nvim-treesitter.configs").setup{
        indent = {
            enable = true,
        },

        highlight = {
            enable = true,
        },

        endwise = {
            enable = true
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,

                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["as"] = "@scope",
                },
            },
        },
    }
end, 0)
