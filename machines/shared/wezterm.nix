{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.frozen-pond.wezterm;
  inherit (lib) mkEnableOption mkIf;
in {
  options.frozen-pond.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [self.packages.${pkgs.system}.wezterm-wrapped];
  };
}
