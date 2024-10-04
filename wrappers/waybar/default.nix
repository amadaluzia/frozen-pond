{
  pkgs,
  inputs,
  ...
}: let
  config = ./config.jsonc;
  style = pkgs.runCommand "style.css" {} ''
    substitute ${./style.css} $out \
      --replace-fail "includes/oxocarbon.css" "${./includes/oxocarbon.css}"
  '';
in {
  wrappers.waybar = {
    basePackage = inputs.waybar.packages.${pkgs.system}.waybar;
    flags = [
      "--config"
      config
      "--style"
      style
    ];
  };
}
