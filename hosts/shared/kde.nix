{ config, lib, ... }:
let
  cfg = config.frozen-pond.kde;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.kde = {
    enable = mkEnableOption "kde";
  };

  config = mkIf cfg.enable { services.desktopManager.plasma6.enable = true; };
}
