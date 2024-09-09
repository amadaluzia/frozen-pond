{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.socials;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.socials = {
    element = mkEnableOption "socials";
    vesktop = mkEnableOption "socials";
  };

  config = {
    environment.systemPackages = [
      (lib.mkIf cfg.vesktop pkgs.vesktop)
      (lib.mkIf cfg.element pkgs.element-desktop)
    ];
  };
}
