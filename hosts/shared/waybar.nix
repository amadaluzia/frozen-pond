{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.frozen-pond.waybar;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.waybar = {
    enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = inputs.self.packages.${pkgs.system}.waybar-wrapped;
    };
  };
}
