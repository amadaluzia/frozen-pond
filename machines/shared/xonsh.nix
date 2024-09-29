{
  config,
  inputs,
  pkgs,
  ...
}: {
  config = {
    programs = {
      command-not-found = {
        enable = true;
        dbPath = inputs.flake-programs-sqlite.packages.${pkgs.system}.programs-sqlite;
      };
      xonsh = {
        enable = true;
        package = inputs.self.packages.${pkgs.system}.xonsh-wrapped;
      };
    };

    environment.systemPackages = [
      config.programs.starship.package
      pkgs.eza
    ];
  };
}
