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
  gtk = {
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = prefer-dark;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = prefer-dark;
    };
  };
}
