{ config, lib, pkgs, ... }:
let
  cfg = config.frozen-pond.direnv;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.frozen-pond.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      direnvrcExtra = builtins.readFile ./configs/direnvrc;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
