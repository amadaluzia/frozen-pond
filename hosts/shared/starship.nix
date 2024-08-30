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
        add_newline = false;
        format = ''$username$directory$character'';
        right_format = ''$all'';
        character = {
          success_symbol = "[󰇵 ](bold green)";
          error_symbol = "[󰇸 ](bold red)";
        };
        username = {
          show_always = true;
          disabled = false;
        };
        line_break.disabled = true;
      };
    };
  };
}
