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
    clipboard = lib.mkEnableOption "opinionated nvf clipboard handling";
    enable = lib.mkEnableOption "opinionated nvf config";

    languages = {
      enable = lib.mkEnableOption "opinionated nix config";
      nix.enable = lib.mkEnableOption "opinionated nix config";
      php.enable = lib.mkEnableOption "opinionated php config";
      rust.enable = lib.mkEnableOption "opinionated rust config";
      ts.enable = lib.mkEnableOption "opinionated ts config";
    };

    plugins = {
      git.enable = lib.mkEnableOption "opinionated git plugins config";
      notes.enable = lib.mkEnableOption "opinionated notes plugins config";
      terminal.enable = lib.mkEnableOption "opinionated terminal plugins config";
      ui.enable = lib.mkEnableOption "opinionated ui plugins config";
      utility.enable = lib.mkEnableOption "opinionated utility plugins config";
      visuals.enable = lib.mkEnableOption "opinionated visuals plugins config";
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
