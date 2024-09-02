{ config, lib, pkgs, ... }:
let
  cfg = config.frozen-pond.misc;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.frozen-pond.misc = {
    sudo_prompt = mkEnableOption "sudo prompt";
    wayland = mkEnableOption "wayland";
  };

  config = lib.mkMerge [
    (mkIf cfg.sudo_prompt {
      environment.variables = {
        "SUDO_PROMPT" = "$(tput setaf 0 setab 3)/!\\ ROOT ACTION! TYPE PASSWORD!$(tput sgr0) ";
      };
    })
    (mkIf cfg.wayland {
      environment.systemPackages = [
        pkgs.swaybg
        pkgs.grim
        pkgs.slurp
        pkgs.wl-clipboard
        pkgs.wf-recorder
      ];

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      programs.dconf.enable = true;
    })
  ];
}
