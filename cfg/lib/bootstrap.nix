{ pkgs }:
{ config, ...}:
{
  # Expose pkgs to the module system
  config._module.args = {
    inherit pkgs;
  };
}