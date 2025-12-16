{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.base16) accent;

  colour = if accent == "magenta" then "purple" else accent;

  cfg = config.ozzie.workstation.starship;
in
{
  options.ozzie.workstation.starship = {
    enable = lib.mkEnableOption "opinionated starship config";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      package = with pkgs; starship;

      settings = {
        aws.symbol = " ";
        buf.symbol = " ";
        c.symbol = " ";
        cmake.symbol = " ";
        cmd_duration.format = " \\[[⏱ $duration]($style)\\]";
        conda.symbol = " ";
        crystal.symbol = " ";
        dart.symbol = " ";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";
        golang.symbol = " ";
        git_commit.tag_symbol = "  ";
        gradle.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        kotlin.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        perl.symbol = " ";
        pijul_channel.symbol = " ";
        python.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        scala.symbol = " ";
        swift.symbol = " ";
        zig.symbol = " ";

        character = {
          error_symbol = "[❯](red bold)";
          success_symbol = "[❯](green bold)";
          vimcmd_replace_one_symbol = "[❮](red)";
          vimcmd_replace_symbol = "[❮](red bold)";
          vimcmd_symbol = "[❮](blue bold)";
          vimcmd_visual_symbol = "[❮](${colour} bold)";
        };

        directory = {
          read_only = " 󰌾";
          truncation_length = 5;
          truncation_symbol = "…/";
        };

        gcloud = {
          format = " \\[[$symbol$account(@$domain)(\\($region\\))]($style)\\]";
          symbol = "󱇶 ";
        };

        git_branch = {
          format = "[$symbol$branch](${colour})";
          symbol = " ";
        };

        git_status = {
          ahead = "[⇡\${count}](grey)";
          behind = "[⇣\${count}](grey)";
          conflicted = "[\${count}≠](bold red)";
          deleted = "[\${count}✘](bold red)";
          diverged = "[⇕⇡\${ahead_count}⇣\${behind_count}](bold red)";
          format = "(( $ahead_behind)(( $staged)( $modified)( $conflicted)( $deleted)( $renamed)( $untracked)( $stashed)))";
          modified = "[\${count}☒](blue)";
          renamed = "[\${count}»](bold red)";
          staged = "[\${count}☑](yellow)";
          stashed = "[\${count}$](red)";
          untracked = "[\${count}☐](cyan)";
        };

        hostname = {
          format = "[$hostname]($style):";
          ssh_only = false;
          ssh_symbol = " ";
          style = "${colour} dimmed";
        };

        lua = {
          format = " \\[[$symbol($version)]($style)\\]";
          symbol = " ";
        };

        nix_shell = {
          format = " \\[[$symbol(($name)$state)]($style)\\]";
          impure_msg = "*";
          pure_msg = "";
          symbol = " ";
          unknown_msg = "?";
        };

        nodejs = {
          format = " \\[[$symbol($version)]($style)\\]";
          symbol = " ";
        };

        package = {
          format = " \\[[$symbol($version)]($style)\\]";
          symbol = "󰏗 ";
        };

        php = {
          format = " \\[[$symbol($version)]($style)\\]";
          symbol = " ";
        };

        rust = {
          format = " \\[[$symbol($version)]($style)\\]";
          symbol = "󱘗 ";
        };

        status = {
          disabled = false;
          format = "[$symbol$status]($style) ";
          map_symbol = true;
          not_executable_symbol = "⊘ ";
          not_found_symbol = "? ";
          sigint_symbol = "󰓛 ";
          signal_symbol = "! ";
          success_symbol = "";
          symbol = "⤫ ";
        };

        username = {
          format = "[$user]($style)@";
          show_always = true;
          style_root = "red";
          style_user = "${colour}";
        };
      };
    };
  };
}
