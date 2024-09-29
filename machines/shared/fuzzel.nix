{
  lib,
  config,
  pkgs,
  self,
  ...
}: let
  cfg = config.frozen-pond.fuzzel;
  inherit (lib) mkEnableOption mkIf;
in {
  options.frozen-pond.fuzzel = {
    enable = mkEnableOption "fuzzel";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [self.packages.${pkgs.system}.fuzzel-wrapped];
  };
}
