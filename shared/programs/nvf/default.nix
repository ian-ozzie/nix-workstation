{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf;
in
{
  options.ozzie.workstation.nvf = {
    enable = lib.mkEnableOption "opinionated nvf config";
    clipboard = lib.mkEnableOption "opinionated nvf clipboard handling";
  };

  imports = [
    ./binds.nix
    ./misc.nix
    ./options.nix

    ./plugins
  ];

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      enableManpages = true;

      settings.vim = {
        clipboard.enable = lib.mkDefault cfg.clipboard;
        viAlias = lib.mkDefault true;
        vimAlias = lib.mkDefault true;

        theme = {
          enable = true;
          name = lib.mkForce "catppuccin";
          style = lib.mkForce "mocha";
          transparent = lib.mkForce false;
        };
      };
    };
  };
}
