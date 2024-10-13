{
  inputs,
  pkgs,
  ...
}: let
  niri-dconf-script = pkgs.writeShellApplication {
    name = "niri-dconf-script.sh";
    runtimeInputs = [pkgs.dconf];
    text = builtins.readFile ./scripts/dconf.sh;
  };
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
          pathAdd = [niri-dconf-script];
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
  frozen-pond = {
    fuzzel.enable = true;
    mako.enable = true;
    waybar.enable = true;
    misc.wayland = true;
  };
  services.gnome.gnome-keyring.enable = true;
}
