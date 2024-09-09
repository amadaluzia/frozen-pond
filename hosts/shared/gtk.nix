{
  config,
  pkgs,
  lib,
  username,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  currentThemePackage = inputs.gtk.packages.${pkgs.system}.gtkNix;
  currentIconPackage = pkgs.qogir-icon-theme;
  currentCursorPackage = pkgs.simp1e-cursors;
in
{
  config = mkIf (builtins.isString config.frozen-pond.desktop) {
    environment.systemPackages = [
      currentThemePackage
      currentIconPackage
      currentCursorPackage
      pkgs.glib
      pkgs.libsForQt5.qt5ct
    ];

    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };

    programs.dconf.enable = true;

    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
          currentTheme = "${currentThemePackage}/share/themes/GtkNix";
        in
        [
          "L+ ${homeDir}/.config/gtk-3.0 644 - - - ${currentTheme}/gtk-3.0"
          "L+ ${homeDir}/.config/qt5ct/colors 644 - - - ${./configs/qt5ct/colors/.}"
        ];
    };
  };
}
