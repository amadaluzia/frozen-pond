{ username, config, pkgs, lib, ... }:
let
  cfg = config.frozen-pond.git;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.frozen-pond.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      # config = {
      #   user = {
      #     name = "Artur Manuel";
      #     email = "balkenix@outlook.com";
      #     signingKey = "7ECEF174";
      #   };
      #   commit = {
      #     gpgsign = true;
      #   };
      # };
    };

    systemd.user.tmpfiles.rules = [
      "L+ /home/${username}/.gitconfig - - - - ${./. + "/configs/git/gitconfig"}"
    ];
  };
}
