{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.frozen-pond.qutebrowser;
in
{
  options.frozen-pond.qutebrowser = {
    enable = lib.mkEnableOption "qutebrowser";
  };

  config = lib.mkIf cfg.enable { environment.systemPackages = [ pkgs.qutebrowser ]; };
}
