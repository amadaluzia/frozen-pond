{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.frozen-pond.desktop == "cosmic") {
    frozen-pond.misc.wayland = true;
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
