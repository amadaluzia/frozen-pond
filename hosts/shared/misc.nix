{ config, lib, ... }:
let
  cfg = config.frozen-pond.misc;
in
{
  options.frozen-pond.misc = {
    sudo_prompt = lib.mkEnableOption "sudo prompt";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.sudo_prompt {
      environment.variables = {
        "SUDO_PROMPT" = "$(tput setaf 0 setab 3)/!\\ ROOT ACTION! TYPE PASSWORD!$(tput sgr0) ";
      };
    })
  ];
}
