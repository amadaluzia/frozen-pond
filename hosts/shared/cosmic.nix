{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.frozen-pond.desktop == "cosmic") {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
