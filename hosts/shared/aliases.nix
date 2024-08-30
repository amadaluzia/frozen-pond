{ hostname, ... }:
{
  environment.shellAliases = {
    "rebs" = "sudo nixos-rebuild switch --flake /etc/nixos#${hostname}";
  };
}
