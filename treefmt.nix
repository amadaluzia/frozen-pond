_: {
  projectRootFile = "flake.nix";
  programs = {
    prettier.enable = true;
    alejandra.enable = true;
    statix.enable = true;
    deadnix.enable = true;
    black.enable = true;
    stylua.enable = true;
    shellcheck.enable = true;
  };
  settings.formatter.prettier.excludes = ["machines/shared/chromium/bookmarks.html"];
}
