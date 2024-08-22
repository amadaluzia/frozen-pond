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
      modules = [
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
              settings.extra-experimental-features = [
                "nix-command"
                "flakes"
              ];
            };
            environment.systemPackages = [ inputs.whyfetch.packages.${pkgs.system}.whyfetch ];
          };
        }
        ./${hostname}
        ./shared
      ] ++ extraModules;
      specialArgs = {
        inherit inputs username;
      };
    };
}
