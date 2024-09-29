{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.frozen-pond.fonts;
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) listOf package;
in {
  options.frozen-pond.fonts = {
    enable = mkEnableOption "fonts";
    extraPackages = mkOption {
      type = listOf package;
      description = "Extra fonts to install.";
      default = [pkgs.nerdfonts-symbols];
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      packages =
        (builtins.attrValues {
          inherit (pkgs) sarasa-gothic twemoji-color-font;
          iosevka-comfy-fixed = pkgs.iosevka-comfy.comfy-fixed;
          iosevka-comfy-motion-fixed = pkgs.iosevka-comfy.comfy-motion-fixed;
        })
        ++ cfg.extraPackages;
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = ["Iosevka Comfy Fixed"];
          monospace = ["Iosevka Comfy Fixed"];
          serif = ["Iosevka Comfy Motion Fixed"];
          emoji = ["Twitter Color Emoji"];
        };
      };
    };
  };
}
