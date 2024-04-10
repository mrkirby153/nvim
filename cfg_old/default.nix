{pkgs}: let
  # Read a nix file to a string
  nixToConfig = name: file:
    pkgs.writeTextFile {
      name = pkgs.lib.strings.removeSuffix ".nix" name;
      text = import file {inherit pkgs;};
    };
  # Read a raw file to a string
  sourceToConfig = name: file:
    pkgs.writeTextFile {
      name = name;
      text = builtins.readFile file;
    };
  configLoader = file: (
    if (pkgs.lib.strings.hasSuffix ".nix" file)
    then nixToConfig
    else sourceToConfig
  );
  loadFile = file: (configLoader file) file;
  sourceCommand = file:
    (
      if pkgs.lib.strings.hasSuffix "lua" file
      then "luafile"
      else "source"
    )
    + " ${file}";
  readDirectory = dir: let
    fileNames = builtins.attrNames (builtins.readDir dir);
    loadedFiles = builtins.map (file: loadFile file "${dir}/${file}") fileNames;
  in
    builtins.concatStringsSep "\n" (builtins.map sourceCommand loadedFiles);
in ''
  let configdir = "${./extra}"
  let runtimepath_list = split(&runtimepath, ',')
  call insert(runtimepath_list, configdir, 0)
  let &runtimepath = join(runtimepath_list, ',')
  let &packpath = &runtimepath
  ${builtins.concatStringsSep "\n" (builtins.map readDirectory [./lua])}
''
