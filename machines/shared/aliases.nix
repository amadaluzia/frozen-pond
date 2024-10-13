{hostname, ...}: {
  environment.shellAliases = {
    "rebs" = "nixos-rebuild switch --use-remote-sudo --flake ~/.config/nixos#${hostname}";
    "rebt" = "nixos-rebuild test --use-remote-sudo --flake ~/.config/nixos#${hostname}";
  };
}
