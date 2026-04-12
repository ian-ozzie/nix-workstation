{
  config,
  lib,
  ...
}:
let
  inherit (config.ozzie.workstation) theme;

  prefer-dark = theme.polarity == "dark";
in
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-application-prefer-dark-theme = prefer-dark;
    };
  };
}
