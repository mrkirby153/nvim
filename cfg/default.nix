{pkgs}: let
  nix2Config = dir:
    builtins.map (file:
      pkgs.writeTextFile {
        name = pkgs.lib.strings.removeSuffix ".nix" file;
        text = import ./${dir}/${file} {inherit pkgs;};
      }) (builtins.attrNames (builtins.readDir ./${dir}));
  scripts2Config = dir: let
    configDir = pkgs.stdenv.mkDerivation {
      name = "nvim-${dir}-configs";
      src = ./${dir};
      installPhase = ''
        mkdir -p $out
        cp ./* $out/
      '';
    };
  in
    builtins.map (file: "${configDir}/${file}") (builtins.attrNames (builtins.readDir configDir));
  sourceCommand = file:
    (
      if pkgs.lib.strings.hasSuffix "lua" file
      then "luafile"
      else "source"
    )
    + " ${file}";
  sourceConfigFiles = files:
    builtins.concatStringsSep "\n" (builtins.map (file: sourceCommand file) files);
  vim = scripts2Config "vim";
  lua = scripts2Config "lua";
  luanix = nix2Config "luanix";
in
  builtins.concatStringsSep "\n" (builtins.map (configs: sourceConfigFiles configs) [vim lua luanix])
