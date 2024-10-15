{
  inputs,
  pkgs,
  ...
}: let
  wrapper = inputs.wm.lib {
    inherit pkgs;
    modules = [
      {
        wrappers.niri = {
          basePackage = pkgs.niri-stable;
          env.NIRI_CONFIG = {
            value = ./config.kdl;
            force = true;
          };
        };
      }
    ];
  };
in {
  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    configPackages = [wrapper.config.wrappers.niri.basePackage];
  };
  programs = {
    seahorse.enable = true;
    niri = {
      enable = true;
      package = wrapper.config.build.toplevel.overrideAttrs {passthru.providedSessions = ["niri"];};
    };
  };
  frozen-pond.desktop = "niri";
  services.gnome.gnome-keyring.enable = true;
}
