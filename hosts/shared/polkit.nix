{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.polkit;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.polkit = {
    enable = mkEnableOption "polkit";
  };

  config = mkIf cfg.enable {
    systemd = {
      user.services.polkit-kde-authentication-agent-1 = {
        description = "polkit-kde-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    environment.systemPackages = [ pkgs.kdePackages.polkit-kde-agent-1 ];
  };
}
