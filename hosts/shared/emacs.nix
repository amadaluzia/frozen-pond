{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.emacs;
in
{
  options.frozen-pond.emacs = {
    enable = lib.mkEnableOption "emacs";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf config.frozen-pond.misc.wayland {
      services.emacs = {
        enable = true;
        package = inputs.pankomacs.packages.${pkgs.system}.pankomacs;
        startWithGraphical = true;
        install = true;
        defaultEditor = true;
      };
    })
    (lib.mkIf config.frozen-pond.misc.xorg {
      services.emacs = {
        enable = true;
        package = inputs.pankomacs.packages.${pkgs.system}.pankomacs-x11;
        startWithGraphical = true;
        install = true;
        defaultEditor = true;
      };
    })
  ]);
}
