{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.nix;
in
{
  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      languages.nix = {
        enable = true;
        extraDiagnostics.enable = true;
        treesitter.enable = true;
      };

      lsp.servers = {
        nil.enable = lib.mkForce false;
        nixd.enable = true;
      };
    };
  };
}
