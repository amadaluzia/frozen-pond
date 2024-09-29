{
  username,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.eww;
  inherit (lib) mkEnableOption mkIf;
in {
  options.frozen-pond.eww = {
    enable = mkEnableOption "eww";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.eww
      pkgs.alsa-utils
      pkgs.playerctl
    ];

    # systemd.user.tmpfiles.rules = [
    #   "L+ /home/${username}/.config/eww 0644 - - - ${./configs + "/eww"}"
    # ];
  };
}
