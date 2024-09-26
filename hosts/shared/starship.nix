{ config, lib, ... }:
let
  cfg = config.frozen-pond.starship;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
    };
  };
}
