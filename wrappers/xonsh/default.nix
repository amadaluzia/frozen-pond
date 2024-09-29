{pkgs, ...}: {
  wrappers.xonsh = {
    basePackage = pkgs.xonsh;
    env = {
      XONSHRC = {
        value = "/etc/xonsh/xonshrc:${./xonshrc}";
        force = true;
      };
    };
  };
}
