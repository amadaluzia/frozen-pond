{
  pkgs,
  self,
  config,
  lib,
  ...
}: let
  cfg = config.frozen-pond.mako;
in {
  options.frozen-pond.mako = {
    enable = lib.mkEnableOption "mako";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [self.packages.${pkgs.system}.mako-wrapped];
  };
}
