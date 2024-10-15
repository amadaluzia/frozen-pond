{
  config,
  lib,
  self,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  gtkTheme = self.packages.${pkgs.stdenv.system}.phocus-oxocarbon;
in {
  config = mkIf (builtins.isString config.frozen-pond.desktop) {
    programs.dconf = {
      enable = true;
      profiles.user = {
        databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                icon-theme = "Colloid-pink-dark";
                gtk-theme = "phocus";
                cursor-theme = "Sakuya";
                text-scaling-factor = 1.1;
              };
            };
          }
        ];
        enableUserDb = true;
      };
    };
    systemd.user.tmpfiles.rules = [
      "C+ %h/.config/gtk-3.0 - - - - ${gtkTheme}/share/phocus"
    ];
    qt = {
      enable = true;
      style = "kvantum";
    };
    environment.systemPackages = [
      gtkTheme
      (pkgs.colloid-icon-theme.override {
        schemeVariants = ["default"];
        colorVariants = ["pink"];
      })
      pkgs.touhou-cursors
    ];
    environment.pathsToLink = ["/share/Kvantum"];
  };
}
