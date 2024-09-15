{ pkgs, ... }: {
  wrappers.xonsh = {
    basePackage = pkgs.myxonsh;
    env = {
      XONSHRC = {
        value = ./xonshrc;
        force = true;
      };
      STARSHIP_CONFIG = {
        value = ./starship.toml;
        force = true;
      };
    };
  };
}
