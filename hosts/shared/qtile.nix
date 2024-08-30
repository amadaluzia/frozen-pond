{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.frozen-pond.desktop == "qtile") {
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
