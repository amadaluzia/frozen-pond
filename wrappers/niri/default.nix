{pkgs, ...}: let
  niri-dconf-script = pkgs.writeShellApplication {
    name = "niri-dconf-script.sh";
    runtimeInputs = [pkgs.dconf];
    text = builtins.readFile ./scripts/dconf.sh;
  };
  basePackage = pkgs.niri-stable;
in {
  wrappers.niri = {
    inherit basePackage;
    env.NIRI_CONFIG = {
      value = ./config.kdl;
      force = true;
    };
    pathAdd = [niri-dconf-script];
  };
}
