let
  modules = {
    options = ../options;

    plymouth = ./plymouth.nix;
  };
in
modules
// {
  default = {
    imports = builtins.attrValues modules;
  };
}
