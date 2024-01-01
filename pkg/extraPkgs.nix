{ pkgs }:
# A list of extra packages that should be made available to nvim.
# Put your language servers here.
with pkgs; [
  nil
  nodePackages.typescript-language-server
  elixir
  elixir-ls
  cargo
  rustc
  lua-language-server
]