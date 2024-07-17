local lspconfig = require("lspconfig")

local capabilities = require("capabilities").get_capabilities()
local on_attach = require("capabilities").on_attach

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  }
})
lspconfig.marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})