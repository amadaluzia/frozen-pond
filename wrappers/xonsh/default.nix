{ pkgs, ... }: {
  wrappers.xonsh = {
    basePackage = pkgs.myxonsh;
    env = {
      XONSHRC = {
        value = ./xonshrc;
        force = true;
      };
    };
  };
}
