{
  config,
  lib,
  ...
}: let
  cfg = config.frozen-pond.starship;
  inherit (lib) mkEnableOption mkIf;
in {
  options.frozen-pond.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          error_symbol = "[󰇸 ](bold red)";
          success_symbol = "[󰇵 ](bold green)";
        };
        line_break = {
          disabled = false;
        };
        username = {
          disabled = false;
          show_always = true;
        };
      };
    };
  };
}
