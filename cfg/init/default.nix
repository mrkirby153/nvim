{ config, ...}:
{
  config.nvim.extraConfigFiles.lua = [
    ./01-init.lua
  ];
}