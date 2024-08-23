pkgs: {
  rose-pine-gtk = pkgs.callPackage ./rose-pine-gtk.nix { };
  ringracers = pkgs.callPackage ./ringracers.nix { };
  fzuplock = pkgs.callPackage ./scripts/fzuplock { };
}
