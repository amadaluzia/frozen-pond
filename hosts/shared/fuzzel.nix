{ username, lib, config, pkgs, ... }:
let
  cfg = config.frozen-pond.fuzzel;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.fuzzel = {
    enable = mkEnableOption "fuzzel";
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fuzzel
    ];
    systemd.user = {
      tmpfiles.rules =
        let
          homeDir = "/home/${username}";
          configDir = ./. + "/configs";
        in
        [
          "L+ ${homeDir}/.config/fuzzel 0644 - - - ${configDir}/waybar"
        ];
      };
  };
}
