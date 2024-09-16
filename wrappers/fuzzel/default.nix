{ pkgs, ... }:
{
  wrappers.fuzzel = {
    basePackage = pkgs.fuzzel;
    flags = [
      "--config"
      ./fuzzel.ini
    ];
  };
}
