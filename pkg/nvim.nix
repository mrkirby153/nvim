{pkgs}: let
  customRC = import ../cfg {inherit pkgs;};
  plugins = import ../cfg/plugins.nix {inherit pkgs;};
  runtimeDeps = import ../runtimeDeps.nix {inherit pkgs;};
  wrappedRuntimeDeps = pkgs.symlinkJoin {
    name = "wrappedRuntimeDeps";
    paths = runtimeDeps;
    postBuild = ''
      for f in $out/lib/node_modules/.bin/*; do
        path=$(readlink --canonicalize-missing "$f")
        dest="$out/bin/$(basename $f)"
        if ! [ -f "$dest" ]; then
          ln -s "$path" "$dest"
        fi
      done
    '';
  };
  myNeovim = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      inherit customRC;
      packages.all.start = plugins;
    };
  };
in
  pkgs.writeShellApplication {
    name = "nvim";
    runtimeInputs = [wrappedRuntimeDeps];
    text = ''
      ${myNeovim}/bin/nvim "$@"
    '';
  }
