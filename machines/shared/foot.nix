{
  lib,
  self,
  config,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.foot;
in {
  options.frozen-pond.foot = {
    enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [self.packages.${pkgs.system}.foot-wrapped];
  };
}
