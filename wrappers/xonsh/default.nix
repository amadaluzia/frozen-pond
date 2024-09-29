{pkgs, ...}: {
  wrappers.xonsh = {
    basePackage = pkgs.myonsh;
    env = {
      XONSHRC = {
        value = "/etc/xonsh/xonshrc:${./xonshrc}";
        force = true;
      };
    };
  };
}
