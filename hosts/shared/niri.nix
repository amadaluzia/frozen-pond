{
  lib,
  config,
  pkgs,
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
      wrappers = [ "niri" ];
    };
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.system}.niri-unstable;
    };
  };
}
