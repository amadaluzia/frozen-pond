{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (config.frozen-pond.desktop == "kde") {
    frozen-pond.misc.wayland = true;
    services.desktopManager.plasma6.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
