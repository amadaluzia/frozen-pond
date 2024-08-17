{ inputs, overlays }:
rec {
  mkHost =
    {
      system,
      hostname,
      username,
      extraModules ? [ ],
    }:
    let
      pkgs = import inputs.nixpkgs { inherit system overlays; };
    in
    {
      nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          {
            config = rec {
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
                package = pkgs.nixVersions.latest;
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
    };

  mkHosts = hosts: inputs.nixpkgs.lib.mkMerge (map mkHost hosts);
}
