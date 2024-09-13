{
  lib,
  config,
  pkgs,
  username,
  inputs,
  ...
}:
let
  cfg = config.frozen-pond;
  inherit (lib) mkIf;
in
{
  imports = [ inputs.niri.nixosModules.niri ];
  config = mkIf (cfg.desktop == "niri") {
    frozen-pond = {
      misc.wayland = true;
      waybar.enable = true;
      fuzzel.enable = true;
      mako.enable = true;
    };
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        niri.default = [
          "gnome"
          "gtk"
        ];
      };
    };
    systemd.user.tmpfiles.rules = [ "L+ /home/${username}/.config/niri - - - - ${./configs/niri}" ];
  };
}
