{
  config,
  inputs,
  pkgs,
  username,
  ...
}:
{
  config = {
    programs = {
      command-not-found = {
        enable = true;
        dbPath = inputs.flake-programs-sqlite.packages.${pkgs.system}.programs-sqlite;
      };
      xonsh = {
        enable = true;
        package = pkgs.myxonsh;
      };
    };

    systemd.user.tmpfiles.rules = [ "L+ /home/${username}/.xonshrc - - - - ${./configs/xonshrc}" ];

    environment.systemPackages = [
      config.programs.starship.package
      pkgs.eza
    ];
  };
}
