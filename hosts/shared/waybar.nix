{ username, lib, config, ... }:
let
  cfg = config.frozen-pond.waybar;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.waybar = {
    enable = mkEnableOption "waybar";
  };
  
  config = mkIf cfg.enable {
    programs.waybar.enable = true;
    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
          configDir = ./. + "/configs";
        in
        [
          "L+ ${homeDir}/.config/waybar 0644 - - - ${configDir}/waybar"
        ];
      };
  };
}
