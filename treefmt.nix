_: {
  projectRootFile = "flake.nix";
  programs.alejandra.enable = true;
  programs.stylua.enable = true;
  programs.shellcheck.enable = true;
  programs.prettier.enable = true;
  programs.black.enable = true;
}
