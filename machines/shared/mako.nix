{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.frozen-pond.mako;
in
{
  options.frozen-pond.mako = {
    enable = lib.mkEnableOption "mako";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ inputs.self.packages.${pkgs.system}.mako-wrapped ];
  };
}
