{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.frozen-pond.niri;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };
  };
}
