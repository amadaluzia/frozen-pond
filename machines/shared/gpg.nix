{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.gpg;
  inherit (lib) mkIf mkEnableOption;
in {
  options.frozen-pond.gpg = {
    enable = mkEnableOption "gpg";
  };

  config = {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
  };
}
