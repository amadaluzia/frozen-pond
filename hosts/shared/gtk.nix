{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  cfg = config.frozen-pond.sway;
  inherit (lib) mkIf;
  currentThemePackage = pkgs.tokyonight-gtk-theme;
  currentCursorPackage = pkgs.simp1e-cursors;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      currentThemePackage
      currentCursorPackage
      pkgs.glib
    ];

    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
          currentTheme = "${currentThemePackage}/share/themes/Tokyonight-Storm-BL";
        in
        [
          "L+ ${homeDir}/.config/gtk-4.0 644 - - - ${currentTheme}/gtk-4.0"
          "L+ ${homeDir}/.config/gtk-3.0 633 - - - ${currentTheme}/gtk-3.0"
        ];
    };
  };
}
