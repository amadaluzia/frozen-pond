{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.frozen-pond.virtualisation;
  inherit (lib) mkEnableOption mkIf;
in {
  options.frozen-pond.virtualisation = {
    enable = mkEnableOption "virtualisation";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
