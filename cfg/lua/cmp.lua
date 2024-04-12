local cmp = require("cmp")

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        docuomentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- Scroll the docs up 4
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        -- Scroll the docs down 4
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        -- Show the completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Abort the completion menu
        ['<C-e>'] = cmp.mapping.abort(),
        -- Confirm suggestion
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        -- Move down the completion list
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if #cmp.get_entries() == 1 then
                    cmp.confirm({select = true})
                else
                    cmp.select_next_item()
                end
            else
                fallback()
            end
        end),
        -- Move up the completion list
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end)
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp"},
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    })
}