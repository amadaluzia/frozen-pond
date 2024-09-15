{ config, lib, inputs, pkgs, ... }:
let
  cfg = config.frozen-pond.wezterm;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ inputs.self.packages.${pkgs.system}.wezterm-wrapped ];
    # systemd.user.tmpfiles.rules = [ "L+ ${homeDir}/.config/wezterm 0644 - - - ${./configs/wezterm}" ];
  };
}
