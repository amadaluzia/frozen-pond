{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.gpg;
in {
  options.frozen-pond.gpg = {
    enable = lib.mkEnableOption "gpg";
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };
}
