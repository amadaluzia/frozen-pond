{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.frozen-pond.desktop == "sway") {
    frozen-pond = {
      misc.wayland = true;
      waybar.enable = true;
      fuzzel.enable = true;
      mako.enable = true;
    };

    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        sway.default = [
          "wlr"
          "gtk"
        ];
      };
    };

    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
        in
        [ "L+ ${homeDir}/.config/sway 0644 - - - ${./configs/sway}" ];
      targets.sway-session = {
        description = "sway compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };
    };
  };
}
