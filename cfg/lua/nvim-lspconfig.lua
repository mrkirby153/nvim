local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local servers = {
  tsserver = {},
  nil_ls = {},
  elixirls = {
    cmd = { "elixir-ls" }
  },
  rust_analyzer = {},
}

mason.setup()
mason_lspconfig.setup()

for lsp, cfg in pairs(servers) do
  lspconfig[lsp].setup(cfg)
end
