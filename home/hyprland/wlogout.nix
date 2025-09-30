{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.ozzie.workstation.theme.colours)
    accent
    base
    highlight
    lowlight
    ;

  icons = "${pkgs.wlogout}/share/wlogout/icons";
  cfg = config.ozzie.workstation.wlogout;
in
{
  config = lib.mkIf cfg.enable {
    stylix.targets.hyprlock.enable = false;

    programs.wlogout = {
      layout = [
        {
          action = "systemctl poweroff";
          keybind = "s";
          label = "shutdown";
          text = "Shutdown";
        }
        {
          action = "systemctl reboot";
          keybind = "r";
          label = "reboot";
          text = "Reboot";
        }
        {
          action = "hyprctl dispatch exit";
          keybind = "e";
          label = "logout";
          text = "Exit";
        }
        {
          action = "hyprlock";
          keybind = "l";
          label = "lock";
          text = "Lock";
        }
      ];

      style = ''
        @define-color accent ${accent};
        @define-color base ${base};
        @define-color highlight ${highlight};
        @define-color lowlight ${lowlight};

        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: @base;
        }

        button {
          background-color: @lowlight;
          background-position: center;
          background-repeat: no-repeat;
          background-size: 25%;
          border: 2px solid @highlight;
          border-radius: 0;
          color: @accent;
          margin: 4px;
          text-decoration-color: @accent;
        }

        button:focus, button:active, button:hover {
          background-color: @highlight;
          outline-style: none;
        }

        #lock {
          background-image: image(url("${icons}/lock.png"));
        }

        #logout {
          background-image: image(url("${icons}/logout.png"));
        }

        #shutdown {
          background-image: image(url("${icons}/shutdown.png"));
        }

        #reboot {
          background-image: image(url("${icons}/reboot.png"));
        }
      '';
    };
  };
}
