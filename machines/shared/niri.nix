{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.frozen-pond;
in {
  imports = [inputs.niri.nixosModules.niri];
  config = lib.mkIf (cfg.desktop == "niri") {
    frozen-pond = {
      fuzzel.enable = true;
      mako.enable = true;
      waybar.enable = true;
      misc.wayland = true;
    };
    programs.seahorse.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
