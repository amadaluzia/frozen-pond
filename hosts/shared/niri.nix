{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.frozen-pond;
  inherit (lib) mkIf;
in
{
  config = mkIf (cfg.desktop == "niri") {
    frozen-pond = {
      misc.wayland = true;
      fuzzel.enable = true;
    };
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
      config = {
        common.default = [
          "gnome"
          "gtk"
        ];
      };
    };
  };
}
