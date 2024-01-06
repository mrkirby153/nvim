local M = {}
function M.on_attach(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
    nmap("gr", require('telescope.builtin').lsp_references, "[G]o to [R]eferences")
    nmap("gI", require('telescope.builtin').lsp_implementations, "[G]o to [I]mplementations")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require('telescope.builtin').lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require('telescope.builtin').lsp_workspace_symbols, "[W]orkspace [S]ymbols")


    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer"})

    vim.keymap.set("n", "<leader>Fm", "<cmd>Format<CR>", { noremap = true, desc = "[F]or[m]at current buffer", silent = true})
end

function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    return capabilities
end

return M