{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  cfg = config.frozen-pond.sway;
  inherit (lib) mkEnableOption mkIf;
  currentThemePackage = pkgs.gruvbox-gtk-theme;
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

    environment.systemPackages = [
      currentThemePackage
      pkgs.rose-pine-cursor
      pkgs.rose-pine-icon-theme
      pkgs.glib
    ];

    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
          configDir = ./. + "/configs";
          currentTheme = "${currentThemePackage}/share/themes/Gruvbox-Dark";
          wallpaper = "${../../wallpapers + "/ThingiesCafe.jpg"}";
        in
        [
          "L+ ${homeDir}/.config/sway 0644 - - - ${configDir}/sway"
          "L+ ${homeDir}/.config/wofi 0644 - - - ${configDir}/wofi"
          "L+ ${homeDir}/.config/waybar 0644 - - - ${configDir}/waybar"
          "L+ ${homeDir}/.config/gtk-4.0 644 - - - ${currentTheme}/gtk-4.0"
          "L+ ${homeDir}/.config/gtk-3.0 633 - - - ${currentTheme}/gtk-3.0"
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
