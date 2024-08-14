{ config, lib, ... }:
let
  cfg = config.frozen-pond.cosmic;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.cosmic = {
    enable = mkEnableOption "cosmic";
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
