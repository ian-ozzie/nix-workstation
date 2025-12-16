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

    languages = {
      nix.enable = lib.mkEnableOption "opinionated nix config";
      php.enable = lib.mkEnableOption "opinionated php config";
      rust.enable = lib.mkEnableOption "opinionated rust config";
      ts.enable = lib.mkEnableOption "opinionated ts config";
    };
  };

  imports = [
    ./binds.nix
    ./misc.nix
    ./options.nix
    ./theme.nix

    ./languages
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
      };
    };
  };
}
