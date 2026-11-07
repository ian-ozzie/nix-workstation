{
  lib,
  ...
}:
{
  imports = [
    ./appearance.nix
    ./binds.nix
    ./misc.nix
    ./options.nix

    # ./languages
    # ./plugins
  ];

  config = {
    programs.nvf = {
      enable = true;
      enableManpages = true;

      settings.vim = {
        viAlias = lib.mkDefault true;
        vimAlias = lib.mkDefault true;

        clipboard = {
          enable = lib.mkDefault false;
          registers = lib.mkDefault [ "unnamed" ];
        };
      };
    };
  };
}
