{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.foot;
in {
  options.frozen-pond.foot = {
    enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [inputs.self.packages.${pkgs.stdenv.system}.foot-wrapped];
  };
}
