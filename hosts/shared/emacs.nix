{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.emacs;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.frozen-pond.emacs = {
    enable = mkEnableOption "emacs";
  };

  config = mkIf cfg.enable {
    services.emacs = {
      enable = true;
      package = inputs.pankomacs.packages.${pkgs.system}.pankomacs;
      startWithGraphical = true;
      install = true;
      defaultEditor = true;
    };
  };
}
