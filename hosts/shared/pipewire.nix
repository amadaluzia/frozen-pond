{ config, pkgs, lib, ... }:
let
  cfg = config.frozen-pond.pipewire;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.pipewire = {
    enable = mkEnableOption "pipewire";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      audio.enable = true;
    };
  };
}
