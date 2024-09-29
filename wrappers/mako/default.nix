{pkgs, ...}: {
  wrappers.mako = {
    basePackage = pkgs.mako;
    flags = [
      "--config"
      ./config
    ];
    postBuild = ''
      mv .makoctl-wrapped_ $out/bin/makoctl
    '';
  };
}
