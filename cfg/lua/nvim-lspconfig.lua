local nvim_lsp = require("lspconfig")
require("mason").setup()


local servers = {
  tsserver = {},
  nil_ls = {},
  elixirls = {
    cmd = { "elixir-ls" }
  },
  rust_analyzer = {},
}


for lsp, cfg in pairs(servers) do
  nvim_lsp[lsp].setup(cfg)
end
