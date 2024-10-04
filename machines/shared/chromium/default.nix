{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.frozen-pond.chromium;
  inherit (lib) mkEnableOption mkIf;
in {
  options.frozen-pond.chromium = {
    enable = mkEnableOption "chromium";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
        "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        "clngdbkpkpeebahjckkjfobafhncgmne"
        "dhdgffkkebhmkfjojejmpbldmpobfkfo"
        "cbghhgpcnddeihccjmnadmkaejncjndb"
      ];
      initialPrefs = {
        browser = {
          confirm-to-quit = false;
        };
        bookmark_bar = {
          show_on_all_tabs = false;
        };
        import_bookmarks = true;
        import_bookmarks_from_file = "${./bookmarks.html}";
      };
      defaultSearchProviderEnabled = true;
      defaultSearchProviderSearchURL = "https://search.leptons.xyz/searxng/search?q={searchTerms}";
      defaultSearchProviderSuggestURL = "https://search.leptons.xyz/searxng/autocompleter?autocomplete=brave&safesearch=2&q={searchTerms}";
    };

    environment.systemPackages = [pkgs.brave];
  };
}
