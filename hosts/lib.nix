{ inputs, overlays }:
{
  newNixosSystem =
    {
      system,
      hostname,
      username,
      extraModules ? [ ],
    }:
    let
      pkgs = import inputs.nixpkgs { inherit system overlays; };
    in
    inputs.nixpkgs.lib.nixosSystem {
      modules = extraModules ++ [
        ./${hostname}
        ./shared
        inputs.cosmic.nixosModules.default
        inputs.niri.nixosModules.niri
        {
          config = {
            nixpkgs = {
              inherit overlays;
            };
            networking.hostName = hostname;
            users.users.${username} = {
              name = username;
              home = "/home/${username}";
              isNormalUser = true;
              extraGroups = [
                "wheel"
                "video"
                "audio"
                "input"
                "networkmanager"
                "libvirtd"
              ];
              shell = pkgs.myxonsh;
            };
            nix = {
              settings = {
                extra-experimental-features = [
                  "nix-command"
                  "flakes"
                ];
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            };
            environment.systemPackages = [ inputs.whyfetch.packages.${pkgs.system}.whyfetch ];
          };
        }
      ];
      specialArgs = {
        inherit inputs username hostname;
      };
    };
}
