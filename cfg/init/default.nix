{ config, ...}:
{
  config.nvim.extraConfigFiles.lua = [
    ./01-init.lua
  ];
  config.nvim.extraPython3Packages = ps: [ps.python-lsp-server];
}