{ inputs, overlays }:
{
  newNixosSystem =
    {
      system,
      hostname,
      user ? "artur",
      extraModules ? [ ],
    }:
    let
      pkgs = import inputs.nixpkgs { inherit system overlays; };
    in
    inputs.nixpkgs.lib.nixosSystem {
      modules = extraModules ++ [
        ./${hostname}
        ./shared
        {
          config = {
            nixpkgs = {
              inherit overlays;
            };
            networking.hostName = hostname;
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
            frozen-pond.users = {
              ${user} = {
                groups = [
                  "wheel"
                  "video"
                  "audio"
                  "libvirtd"
                  "networkmanager"
                  "input"
                ];
                packages = [ inputs.whyfetch.packages.${pkgs.stdenv.system}.whyfetch ];
              };
            };
          };
        }
      ];
      specialArgs = {
        inherit inputs hostname;
      };
    };
}
