{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  cfg = config.frozen-pond.emacs;
in {
  options.frozen-pond.emacs = {
    enable = lib.mkEnableOption "emacs";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = builtins.concatLists [
      (lib.optional config.frozen-pond.misc.wayland inputs.pankomacs.packages.${pkgs.system}.pankomacs)
      (lib.optional config.frozen-pond.misc.xorg inputs.pankomacs.packages.${pkgs.system}.pankomacs-x11)
    ];
    environment.variables.EDITOR = "emacs";
  };
}
