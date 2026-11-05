let
  modules = {
    options = ../options;

    greetd = ./greetd.nix;
    hyprland = ./hyprland.nix;
    hyprlock = ./hyprlock.nix;
    hyprpolkitagent = ./hyprpolkitagent.nix;
    plymouth = ./plymouth.nix;
    regreet = ./regreet.nix;
    xdg = ./xdg.nix;
  };
in
modules
// {
  default = {
    imports = builtins.attrValues modules;
  };

  hyprland-desktop = { lib, ... }: {
    imports = builtins.attrValues modules;

    ozzie.workstation = {
      hyprland.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault true;
      hyprpolkitagent.enable = lib.mkDefault true;
      plymouth.enable = lib.mkDefault true;
      regreet.enable = lib.mkDefault true;

      xdg = {
        enable = lib.mkDefault true;
        fileChooser = lib.mkDefault "kitty";
      };
    };
  };
}
