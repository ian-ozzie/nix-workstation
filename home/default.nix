let
  modules = { };
in
modules
// {
  default = {
    imports = builtins.attrValues modules;
  };
}
