{pkgs}: let
  bootstrap = import ../cfg/lib/bootstrap.nix {inherit pkgs;};
in
  (pkgs.lib.evalModules {
    modules = [
      bootstrap
      ../cfg/lib/options.nix
      ../cfg
    ];
  })
  .config
  .nvim
  .pkg
