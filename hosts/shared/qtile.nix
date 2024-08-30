{ config, lib, pkgs, ... }:
let
  cfg = config.frozen-pond.qtile;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.qtile = {
    enable = mkEnableOption "qtile";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: builtins.attrValues { inherit (python3Packages) qtile-extras; };
      };
      displayManager.sx.enable = true;
      enable = true;
    };
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        maim
        slop
        ;
    };
  };
}
