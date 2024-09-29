{ pkgs, ... }: {
  wrappers.starship = {
    basePackage = pkgs.starship;
    env.STARSHIP_CONFIG = {
      value = ./starship.toml;
      force = true;
    };
  };
}
