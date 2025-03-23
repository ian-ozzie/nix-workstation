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
