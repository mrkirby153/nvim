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
  lua_ls = {
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
}

mason.setup()
mason_lspconfig.setup()

for lsp, cfg in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = require("capabilities").on_attach,
    capabilities = require("capabilities").get_capabilities(),
    settings = cfg,
    filetypes = cfg.filetypes,
    cmd =cfg.cmd,
    root_pattern = cfg.root_pattern,
  }
end
