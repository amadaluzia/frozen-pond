{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  homeDir = "/home/${username}";
  cfg = config.frozen-pond.wezterm;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.wezterm ];

    systemd.user.tmpfiles.rules = [ "L+ ${homeDir}/.config/wezterm 0644 - - - ${./configs/wezterm}" ];
  };
}
