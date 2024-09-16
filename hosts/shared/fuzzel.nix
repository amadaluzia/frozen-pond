{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.frozen-pond.fuzzel;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.frozen-pond.fuzzel = {
    enable = mkEnableOption "fuzzel";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ inputs.self.packages.${pkgs.system}.fuzzel-wrapped ];
  };
}
