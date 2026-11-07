let
  modules = {
    options = ../options;

    cliphist = ./cliphist.nix;
  };
in
modules
// {
  default = {
    imports = builtins.attrValues modules;
  };

  nvf = { inputs, ... }: {
    imports = [
      inputs.nvf.homeManagerModules.default
      ../shared/nvf
    ];
  };
}
