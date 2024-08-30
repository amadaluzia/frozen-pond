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
    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = [
        pkgs.wezterm
        pkgs.swaybg
        pkgs.fuzzel
        pkgs.pamixer
        pkgs.sway-contrib.grimshot
      ];
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common.default = [
          "wlr"
          "gtk"
        ];
      };
    };

    programs.waybar.enable = true;
    programs.dconf.enable = true;

    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
          configDir = ./. + "/configs";
          wallpaper = "${../../wallpapers + "/ChainsawMan.png"}";
        in
        [
          "L+ ${homeDir}/.config/sway 0644 - - - ${configDir}/sway"
          "L+ ${homeDir}/.config/fuzzel 0644 - - - ${configDir}/fuzzel"
          "L+ ${homeDir}/.config/waybar 0644 - - - ${configDir}/waybar"
          "L+ /tmp/wallpaper 644 - - - ${wallpaper}"
        ];
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
