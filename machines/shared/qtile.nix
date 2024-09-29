{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (config.frozen-pond.desktop == "qtile") {
    frozen-pond.misc.xorg.enable = true;
    services.xserver = {
      windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: builtins.attrValues {inherit (python3Packages) qtile-extras;};
      };
      enable = true;
    };
  };
}
