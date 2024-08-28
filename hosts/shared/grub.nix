{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.grub;
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
in
{
  options.frozen-pond.grub = {
    enable = mkEnableOption "grub";
    efi = mkOption {
      type = types.bool;
      description = "Enable UEFI support for GRUB";
      default = true;
    };
    disko = mkOption {
      type = types.bool;
      description = "If enables, removes the device check.";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = false;
      grub = {
        enable = true;
        efiSupport = cfg.efi;
        device = "nodev";
        enableCryptodisk = true;
        efiInstallAsRemovable = true;
        theme = inputs.dgt.packages.${pkgs.stdenv.system}.nixos-grub-theme;
      };
    };
  };
}
