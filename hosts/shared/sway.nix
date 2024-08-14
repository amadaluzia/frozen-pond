{ config, pkgs, lib, username, ... }:
let
  cfg = config.frozen-pond.sway;
  inherit (lib) mkEnableOption mkIf fakeSha256;
in
{
  options.frozen-pond.sway = {
    enable = mkEnableOption "sway";
  };
  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = [
        pkgs.wezterm
	pkgs.swaybg
	pkgs.wofi
	pkgs.pamixer
      ];
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common.default = [ "wlr" "gtk" ];
      };
    };

    programs.waybar.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = [
      pkgs.rose-pine-gtk-theme
      pkgs.rose-pine-cursor
      pkgs.rose-pine-icon-theme
      pkgs.glib
    ];

    systemd.user = {
      tmpfiles.rules = let
        wallpaper = pkgs.fetchurl {
          url = "https://i.imgur.com/7WGgZt5.png";
          sha256 = "AQSVUxYxtR47G/6tQBdDUB1SPYKuQzqQlJguHgyR8Mk=";
        };

        homeDir = "/home/${username}";
        configDir = ./. + "/configs";
      in [
        "L+ ${homeDir}/.config/sway 0644 - - - ${configDir}/sway"
        "L+ ${homeDir}/.config/wofi 0644 - - - ${configDir}/wofi"
        "L+ ${homeDir}/.config/waybar 0644 - - - ${configDir}/waybar"
        "L+ /tmp/wallpaper - - - - ${wallpaper}"
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
