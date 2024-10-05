{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  cfg = config.frozen-pond.mpd;
in {
  options.frozen-pond.mpd = {
    enable = lib.mkEnableOption "mpd";
  };
  config = lib.mkIf cfg.enable {
    services.mpd.enable = true;
    environment.systemPackages = [
      self.packages.${pkgs.system}.ncmpcpp-wrapped
    ];
  };
}
