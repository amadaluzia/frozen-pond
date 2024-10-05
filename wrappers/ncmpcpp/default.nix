{ pkgs, ... }: {
  wrappers.ncmpcpp = {
    basePackage = pkgs.ncmpcpp;
    flags = [
      "-c"
      ./config
    ];
  };
}
