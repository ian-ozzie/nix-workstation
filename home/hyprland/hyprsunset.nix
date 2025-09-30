{
  config,
  lib,
  ...
}:
let
  cfg = config.ozzie.workstation.hyprsunset;
in
{
  config = lib.mkIf cfg.enable {
    home.file.".config/hypr/hyprsunset.conf".text = ''
      max-gamma = 150

      profile {
        gamma = 0.9
        temperature = 5500
        time = 06:00
      }

      profile {
        temperature = 6000
        time = 06:30
      }

      profile {
        temperature = 6500
        time = 07:00
      }

      profile {
        identity = true
        time = 07:30
      }

      profile {
        temperature = 6000
        time = 18:00
      }

      profile {
        temperature = 5500
        time = 18:30
      }

      profile {
        temperature = 5000
        time = 19:00
      }

      profile {
        temperature = 4500
        time = 19:30
      }

      profile {
        temperature = 4000
        time = 20:00
      }

      profile {
        gamma = 0.9
        temperature = 4000
        time = 20:30
      }

      profile {
        gamma = 0.8
        temperature = 4000
        time = 21:00
      }
    '';
  };
}
