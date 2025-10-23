{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ozzie.workstation.firefox;
in
{
  options.ozzie.workstation.firefox = {
    enable = lib.mkEnableOption "opinionated firefox config";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.firefox.enable = false;

    home.activation.removeFirefoxBackups = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      if [ -f "${config.home.homeDirectory}/files/programs/firefox/profile/search.json.mozlz4.backup" ]; then
        rm -f ${config.home.homeDirectory}/files/programs/firefox/profile/search.json.mozlz4.backup
      fi
    '';

    programs.firefox = {
      enable = true;
      package = with pkgs; firefox;

      profiles."${config.home.username}" = {
        isDefault = true;
        path = "../../files/programs/firefox/profile";

        search = {
          force = true;

          engines = {
            brave = {
              definedAliases = [ "@brave" ];
              icon = "https://upload.wikimedia.org/wikipedia/commons/9/9d/Brave_lion_icon.svg";
              name = "Brave Search";
              urls = [ { template = "https://search.brave.com/search?summary=0&q={searchTerms}"; } ];
            };
            github = {
              definedAliases = [ "@github" ];
              icon = "https://upload.wikimedia.org/wikipedia/commons/c/c2/GitHub_Invertocat_Logo.svg";
              name = "Github Search";
              urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
            };
            google = {
              definedAliases = [ "@google" ];
              icon = "https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg";
              name = "Google Search";
              urls = [ { template = "https://www.google.com.au/search?udm=14&q={searchTerms}"; } ];
            };
            wayback = {
              definedAliases = [ "@wayback" ];
              icon = "https://upload.wikimedia.org/wikipedia/commons/8/84/Internet_Archive_logo_and_wordmark.svg";
              name = "Wayback Machine";
              urls = [ { template = "https://web.archive.org/web/*/{searchTerms}"; } ];
            };
            wikipedia = {
              definedAliases = [ "@wikipedia" ];
              icon = "https://upload.wikimedia.org/wikipedia/en/8/80/Wikipedia-logo-v2.svg";
              name = "Wikipedia (en)";
              urls = [ { template = "https://en.wikipedia.org/w/index.php?search={searchTerms}"; } ];
            };
            youtube = {
              definedAliases = [ "@youtube" ];
              icon = "https://upload.wikimedia.org/wikipedia/commons/f/fd/YouTube_full-color_icon_%282024%29.svg";
              name = "Youtube Search";
              urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
            };

            nixpkgs = {
              definedAliases = [ "nixpkgs" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "Nixpkgs Github";

              urls = [
                {
                  template = "https://github.com/search?type=pullrequests&s=created&o=desc&q=repo:NixOS%2Fnixpkgs+{searchTerms}";
                }
              ];
            };
            nix-git = {
              definedAliases = [ "nix-git" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "Nix Code Github";
              urls = [ { template = "https://github.com/search?type=code&q=lang:nix+{searchTerms}"; } ];
            };
            nix-hardware = {
              definedAliases = [ "nix-hardware" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "NixOS Hardware";

              urls = [
                {
                  template = "https://github.com/search?type=pullrequests&s=created&o=desc&q=repo:NixOS%2Fnixos-hardware+{searchTerms}";
                }
              ];
            };
            nix-home = {
              definedAliases = [ "nix-home" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "Home Manager Options";
              urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
            };
            nix-nvf = {
              definedAliases = [ "nix-nvf" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "Nix nvf";

              urls = [
                {
                  template = "https://github.com/search?type=pullrequests&s=created&o=desc&q=repo:NotAShelf%2Fnvf+{searchTerms}";
                }
              ];
            };
            nix-opt = {
              definedAliases = [ "nix-opt" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "NixOS Options";
              urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];
            };
            nix-pkg = {
              definedAliases = [ "nix-pkg" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "NixOS Packages";
              urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
            };
            nix-stylix = {
              definedAliases = [ "nix-stylix" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "Nix stylix";

              urls = [
                {
                  template = "https://github.com/search?type=pullrequests&s=created&o=desc&q=repo:nix-community%2Fstylix+{searchTerms}";
                }
              ];
            };
            nix-wiki = {
              definedAliases = [ "nix-wiki" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "NixOS Wiki";
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
            };
            noogle = {
              definedAliases = [ "noogle" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              name = "Noogle";
              urls = [ { template = "https://noogle.dev/q?term={searchTerms}"; } ];
            };
          };
        };

        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.formfill.enable" = false;
          "browser.ml.enable" = false;
          "browser.newtabpage.enabled" = false;
          "browser.sessionstore.resume_from_crash" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 1;
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.urlbar.quicksuggest.scenario" = "history";
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.available" = "off";
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "intl.accept_languages" = "en-AU, en-US, en";
          "media.autoplay.default" = 5;
          "network.cookie.lifetimePolicy" = 0;
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.offlineApps" = false;
          "privacy.clearOnShutdown.openWindows" = false;
          "privacy.clearOnShutdown.sessions" = false;
          "privacy.clearOnShutdown.siteSettings" = false;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false; # Not sure what this does.
          "signon.rememberSignons" = false;
        };
      };
    };
  };
}
