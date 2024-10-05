{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.frozen-pond.socials;
in {
  imports = [inputs.flatpak.nixosModules.nix-flatpak];

  options.frozen-pond.socials = {
    element = lib.mkEnableOption "Element";
    vesktop = lib.mkEnableOption "Vesktop";
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = lib.optional cfg.element pkgs.element-desktop;
    }
    (lib.mkIf cfg.vesktop {
      services.flatpak = {
        enable = true;
        packages = [
          "dev.vencord.Vesktop"
        ];
      };
    })
  ];
}
