{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation) theme;
in
{
  stylix = {
    base16Scheme = lib.mkDefault theme.base16.scheme;
    enable = lib.mkDefault true;
    image = lib.mkDefault ./wallpaper.png;
    polarity = lib.mkDefault theme.polarity;

    cursor = {
      name = lib.mkDefault "phinger-cursors-light";
      package = lib.mkDefault pkgs.phinger-cursors;
      size = lib.mkDefault 24;
    };

    fonts = {
      emoji = {
        name = lib.mkDefault "Noto Color Emoji";
        package = lib.mkDefault pkgs.noto-fonts-color-emoji;
      };

      monospace = {
        name = lib.mkDefault "DejaVuSansM Nerd Font";
        package = lib.mkDefault pkgs.nerdfonts;
      };

      sansSerif = {
        name = lib.mkDefault "DejaVu Sans";
        package = lib.mkDefault pkgs.dejavu_fonts;
      };

      serif = {
        name = lib.mkDefault "DejaVu Serif";
        package = lib.mkDefault pkgs.dejavu_fonts;
      };

      sizes = {
        applications = lib.mkDefault 12;
        desktop = lib.mkDefault 16;
        popups = lib.mkDefault 16;
        terminal = lib.mkDefault 12;
      };
    };

    opacity = {
      applications = lib.mkDefault 1.0;
      desktop = lib.mkDefault 1.0;
      popups = lib.mkDefault 1.0;
      terminal = lib.mkDefault 0.9;
    };
  };
}
