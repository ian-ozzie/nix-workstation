let
  modules = {
    options = ../options;

    greetd = ./greetd.nix;
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
