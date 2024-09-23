pkgs: {
  rose-pine-gtk = pkgs.callPackage ./rose-pine-gtk.nix { };
  ringracers = pkgs.callPackage ./ringracers.nix { };
  fzuplock = pkgs.callPackage ./scripts/fzuplock { };
  myppuccin-gtk = pkgs.catppuccin-gtk.override {
    accents = pkgs.lib.singleton "green";
    variant = "mocha";
    tweaks = [ "rimless" ];
  };
  myppuccin-kvantum = pkgs.catppuccin-kvantum.override {
    accent = "Green";
    variant = "Mocha";
  };
}
