{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.frozen-pond.awesome;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.awesome = {
    enable = mkEnableOption "awesome";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
      displayManager.sx.enable = true;
      enable = true;
    };
  };
}
