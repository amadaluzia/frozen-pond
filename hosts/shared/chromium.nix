{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.frozen-pond.chromium;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.chromium = {
    enable = mkEnableOption "chromium";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "pgbjifpikialeahbdendkjioeafbmfkn" # Tokyo Night Storm
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
        "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        "clngdbkpkpeebahjckkjfobafhncgmne"
        "dhdgffkkebhmkfjojejmpbldmpobfkfo"
      ];
      initialPrefs = {
        "browser" = {
          "confirm-to-quit" = false;
        };
      };
    };

    environment.systemPackages = [ pkgs.chromium ];
  };
}
