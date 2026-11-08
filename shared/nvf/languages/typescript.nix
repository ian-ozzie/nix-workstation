{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.nvf.languages.typescript;
in
{
  options.ozzie.workstation.nvf.languages.typescript = {
    enable = lib.mkEnableOption "opinionated typescript config" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings.vim = {
      autocmds = lib.mkIf config.ozzie.workstation.nvf.binds [
        {
          event = [ "LspAttach" ];

          callback = lib.generators.mkLuaInline ''
            function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "typescript-language-server" then
                vim.keymap.set("n", "<leader>lA", "<cmd>LspTypescriptSourceAction<CR>", {
                  buffer = args.buf,
                  silent = true,
                })
              end
            end
          '';
        }
      ];

      diagnostics.nvim-lint = {
        linters_by_ft.javascript = [ "eslint_d" ];

        linters.eslint_d.required_files = lib.mkForce [
          "eslint.config.mjs"
        ];
      };

      formatter.conform-nvim.setupOpts.formatters.prettier.command = lib.mkForce (
        lib.generators.mkLuaInline ''
          function(self, ctx)
            local root = vim.fs.root(ctx.filename, function(name, path)
              return name == "node_modules" and vim.fn.executable(vim.fs.joinpath(path, name, ".bin/prettier")) == 1
            end)
            return root and vim.fs.joinpath(root, "node_modules/.bin/prettier") or "${lib.getExe pkgs.prettier}"
          end
        ''
      );

      languages = {
        typescript = {
          enable = true;

          extraDiagnostics = {
            enable = true;
            types = [ "eslint_d" ];
          };

          format = {
            enable = true;
            type = [ "prettier" ];
          };
        };
      };
    };
  };
}
