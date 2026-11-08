{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.php;
in
{
  options.ozzie.workstation.nvf.languages.php = {
    enable = lib.mkEnableOption "opinionated php config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      languages = {
        php.enable = true;
      };

      extraPlugins.neotest-pest.package = pkgs.vimPlugins.neotest-pest.overrideAttrs {
        version = "unstable-3388a5f";

        src = pkgs.fetchFromGitHub {
          hash = "sha256-BJv981/wPG/1YjOcX/DFbRhbZbmV0TQoaRISP+DNW0E=";
          owner = "V13Axel";
          repo = "neotest-pest";
          rev = "3388a5f00001303020ce885e18007ccd1835212c";
        };
      };

      extraPlugins.neotest.setup = ''
        require("neotest").setup({
          adapters = {
            require("neotest-pest")({
              root_files = { "composer.json", "tests/Pest.php" },
              pest_cmd = "vendor/bin/pest",
              sail_enabled = function() return false end,
            }),
          },
        })
      '';

      lsp.servers.phpactor.init_options = {
        "language_server_configuration.auto_config" = false;
        "language_server_phpstan.enabled" = false;
        "language_server_psalm.enabled" = false;
        "language_server_php_cs_fixer.enabled" = false;
        "language_server_worse_reflection.diagnostics.enable" = false;
        "language_server_worse_reflection.inlay_hints.enable" = false;
      };

      formatter.conform-nvim = {
        setupOpts = {
          formatters_by_ft.php = lib.generators.mkLuaInline ''
            { "pint", lsp_format = "never" }
          '';

          formatters.pint = {
            command = lib.generators.mkLuaInline ''
              function(self, ctx)
                local root = vim.fs.root(ctx.filename, function(name, path)
                  return name == "vendor" and vim.uv.fs_stat(vim.fs.joinpath(path, name, "bin/pint")) ~= nil
                end)
                return root and vim.fs.joinpath(root, "vendor/bin/pint") or "pint"
              end
            '';

            cwd = lib.generators.mkLuaInline ''
              function(self, ctx)
                return vim.fs.root(ctx.filename, { "pint.json", "composer.json" })
              end
            '';
          };
        };
      };

      pluginRC.phpstan-project = {
        after = [ "nvim-lint" ];
        before = [ ];

        data = ''
          local ok, lint = pcall(require, "lint")
          if ok then
            local phpstan = lint.linters.phpstan
            lint.linters.phpstan = function()
              local linter = vim.deepcopy(phpstan)
              local root = vim.fs.root(0, function(name, path)
                return name == "vendor" and vim.uv.fs_stat(vim.fs.joinpath(path, name, "bin/phpstan")) ~= nil
              end)
              if root then
                linter.cmd = vim.fs.joinpath(root, "vendor/bin/phpstan")
              end
              linter.cwd = root or vim.fs.root(0, "composer.json")
              return linter
            end
          end
        '';
      };

      autocmds = [
        {
          event = [ "FileType" ];
          pattern = [ "php" ];

          callback = lib.generators.mkLuaInline ''
            function(args)
              vim.bo[args.buf].shiftwidth = 4
              vim.bo[args.buf].tabstop = 4
              if nvf_lint then
                nvf_lint(args.buf)
              end
            end
          '';
        }
      ];
    };
  };
}
