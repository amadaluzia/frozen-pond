{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.frozen-pond.misc;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.frozen-pond.misc = {
    sudo_prompt = mkEnableOption "sudo prompt";
    wayland = mkEnableOption "wayland";
    xorg = mkEnableOption "xorg";
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

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
      };
      programs = {
        dconf.enable = true;
        hyprlock.enable = true;
      };
      xdg.portal.enable = true;
      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true;
      fonts.enableDefaultPackages = true;
    })
    (mkIf cfg.xorg {
      services.xserver = {
        enable = true;
        displayManager.sx.enable = true;
      };
      environment.systemPackages = [
        pkgs.maim
        pkgs.slop
        pkgs.xclip
        pkgs.vokoscreen-ng
      ];
    })
  ];
}
