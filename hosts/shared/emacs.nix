{
  config,
  pkgs,
  inputs,
  lib,
  username,
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

    systemd.user.tmpfiles.rules = [
      "L+ /home/${username}/.config/emacs 0644 - - - ${./configs/emacs}"
    ];
  };
}
