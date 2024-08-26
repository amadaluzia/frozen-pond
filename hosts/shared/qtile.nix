{
  config,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.qtile;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.qtile = {
    enable = mkEnableOption "qtile";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      windowManager.qtile = {
        enable = true;
      };
      displayManager.sx.enable = true;
      enable = true;
    };
  };
}
