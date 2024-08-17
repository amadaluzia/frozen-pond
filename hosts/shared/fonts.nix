{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.fonts;
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) listOf package;
in
{
  options.frozen-pond.fonts = {
    enable = mkEnableOption "fonts";
    extraPackages = mkOption {
      type = listOf package;
      description = "Extra fonts to install.";
      default = [ pkgs.nerdfonts-symbols ];
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      packages =
        (with pkgs; [
          recursive
          merriweather
          twemoji-color-font
          mplus-outline-fonts.githubRelease
        ])
        ++ cfg.extraPackages;
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ "Recursive Sans Casual Static" ];
          monospace = [ "Recursive Mono Casual Static" ];
          serif = [ "Merriweather" ];
          emoji = [ "Twitter Color Emoji" ];
        };
      };
    };
  };
}
