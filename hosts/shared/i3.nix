{ config, lib, pkgs, ... }:
let
  cfg = config.frozen-pond.i3;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.i3 = {
    enable = mkEnableOption "i3";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      windowManager.i3 = {
        enable = true;
        extraPackages = [
          (pkgs.polybar.override { i3Support = true; })
          pkgs.rofi
        ];
      };
      displayManager.sx.enable = true;
      enable = true;
    };
  };
}
