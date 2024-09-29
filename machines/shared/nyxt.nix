{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.nyxt;
in {
  options.frozen-pond.nyxt = {
    enable = lib.mkEnableOption "nyxt";
    default = lib.mkEnableOption "nyxt";
  };

  config = lib.mkIf cfg.enable {environment.systemPackages = [pkgs.nyxt];};
}
