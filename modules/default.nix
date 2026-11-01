let
  modules = {
    options = ../options;
  };
in
modules
// {
  default = {
    imports = builtins.attrValues modules;
  };
}
