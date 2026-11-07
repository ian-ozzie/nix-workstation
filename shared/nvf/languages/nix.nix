{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.nix;
in
{
  options.ozzie.workstation.nvf.languages.nix = {
    enable = lib.mkEnableOption "opinionated nix config" // {
      default = true;
    };

    nixd = {
      nixpkgsExpr = lib.mkOption {
        type = lib.types.str;
        default = "import ${pkgs.path} { }";
      };

      optionExprs = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };

        example = {
          nixos = ''(builtins.getFlake "/path/to/flake").nixosConfigurations.hostname.options'';
          home_manager = ''(builtins.getFlake "/path/to/flake").homeConfigurations."user@hostname".options'';
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      languages.nix = {
        enable = true;
        extraDiagnostics.enable = true;
        lsp.servers = [ "nixd" ];
        treesitter.enable = true;

        format = {
          enable = true;
          type = [ "nixfmt" ];
        };
      };

      lsp.servers.nixd.settings.nixd = {
        formatting.command = [ (lib.getExe pkgs.nixfmt) ];
        nixpkgs.expr = cfg.nixd.nixpkgsExpr;
        options = lib.mapAttrs (_: expr: { inherit expr; }) cfg.nixd.optionExprs;
      };

      autocmds = [
        {
          event = [ "FileType" ];
          pattern = [ "nix" ];

          callback = lib.generators.mkLuaInline ''
            function(args)
              nvf_lint(args.buf)
            end
          '';
        }
      ];
    };
  };
}
