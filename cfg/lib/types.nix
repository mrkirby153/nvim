{ lib }:
{
  lambdaList = lib.types.mkOptionType {
    name = "lambdaList";
    description = "a lambda";
    merge = loc: defs:
      builtins.map (def: if builtins.isFunction def.value then def.value else throw "${builtins.concatStringsSep "." loc} not a function in ${def.file}") defs;
  };
}