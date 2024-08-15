{ lib, config, inputs, pkgs, ... }:
let
  cfg = config.frozen-pond.neovim;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.frozen-pond.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.nixstart.packages.${pkgs.stdenv.system}.nvim
    ];

    environment.shellAliases = {
      "v" = "nvim";
    };
  };
}
