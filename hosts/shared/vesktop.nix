{ config, pkgs, lib, ... }:
let
  cfg = config.frozen-pond.vesktop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.vesktop = {
    enable = mkEnableOption "vesktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.vesktop
    ];
  };
}
