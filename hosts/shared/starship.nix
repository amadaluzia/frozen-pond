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
      settings = {
        character = {
          success_symbol = "[󰇵 ](bold green)";
          error_symbol = "[󰇸 ](bold green)";
        };
        format = "$username in $directory$character";
        right_format = "$all";
      };
    };
  };
}
