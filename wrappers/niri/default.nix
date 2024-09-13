{ pkgs, inputs, ... }:
let
  niri-dconf-script = pkgs.writeShellApplication {
    name = "niri-dconf-script.sh";
    runtimeInputs = [
      pkgs.dconf
    ];
    text = builtins.readFile ./scripts/dconf.sh;
  };
in
{
  wrappers.niri = {
    basePackage = inputs.niri.packages.${pkgs.system}.niri-unstable;
    env.NIRI_CONFIG = {
      value = ./config.kdl;
      force = true;
    };
    pathAdd = [
      niri-dconf-script
    ];
  };
}
