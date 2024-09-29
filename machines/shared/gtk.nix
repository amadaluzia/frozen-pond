{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  gtkTheme = pkgs.myppuccin-gtk;
  qtTheme = pkgs.myppuccin-kvantum;
in {
  config = mkIf (builtins.isString config.frozen-pond.desktop) {
    environment.systemPackages = [
      gtkTheme
      qtTheme
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.simp1e-cursors
      pkgs.qogir-icon-theme
    ];
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };
    environment.pathsToLink = ["/share/Kvantum"];
    programs.dconf.enable = true;
  };
}
