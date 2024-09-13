{
  username,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.mako;
  mako = pkgs.mako;
in
{
  options.frozen-pond.mako = {
    enable = lib.mkEnableOption "mako";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ mako ];

    systemd.user.tmpfiles.rules = [ "L+ /home/${username}/.config/mako - - - - ${./configs/mako}" ];
  };
}
