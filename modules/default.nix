let
  modules = {
    options = ../options;

    plymouth = ./plymouth.nix;
    regreet = ./regreet.nix;
  };
in
modules
// {
  default = {
    imports = builtins.attrValues modules;
  };
}
