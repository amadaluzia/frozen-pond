{ hostname, ... }:
{
  environment.shellAliases = {
    "rebs" = "nixos-rebuild switch --use-remote-sudo --flake /etc/nixos#${hostname}";
  };
}
