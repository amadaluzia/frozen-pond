{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.frozen-pond.socials;
in {
  options.frozen-pond.socials = {
    element = lib.mkEnableOption "socials";
    vesktop = lib.mkEnableOption "socials";
  };

  config = {
    environment.systemPackages = [
      (lib.mkIf cfg.vesktop pkgs.vesktop)
      (lib.mkIf cfg.element pkgs.element-desktop)
    ];
  };
}
