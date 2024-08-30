{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.frozen-pond.desktop == "kde") {
    services.desktopManager.plasma6.enable = true;
  };
}
