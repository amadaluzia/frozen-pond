{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.frozen-pond.users;
  inherit (lib) types mkOption;
in {
  options.frozen-pond.users = mkOption {
    default = {};
    type = types.attrsOf (
      types.submodule {
        options = {
          groups = mkOption {
            type = types.listOf types.str;
            default = ["wheel"];
            example = [
              "wheel"
              "audio"
              "video"
              "input"
              "libvirtd"
              "networkmanager"
            ];
            description = "Groups you could add to users.";
          };
          packages = mkOption {
            type = types.listOf types.package;
            default = [];
            example = [pkgs.tty-clock];
            description = "Packages users could install.";
          };
        };
      }
    );
  };

  config = {
    users.users =
      builtins.mapAttrs (user: ucfg: {
        name = user;
        home = "/home/${user}";
        description = lib.concatMapStrings (
          x: let
            nac = lib.stringToCharacters user;
          in
            (lib.toUpper (builtins.head nac)) + lib.concatStrings (builtins.tail nac)
        ) [user];
        isNormalUser = true;
        extraGroups = ucfg.groups;
        inherit (ucfg) packages;
        shell = pkgs.myonsh;
      })
      cfg;
  };
}
