{
  inputs,
  overlays,
}: let
  mkMachine = {
    system,
    hostname,
    user ? "artur",
    extraModules ? [],
  }: let
    pkgs = import inputs.nixpkgs {inherit system overlays;};
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      modules =
        extraModules
        ++ [
          ./${hostname}
          ./shared
          {
            config = {
              networking.hostName = hostname;
              nix = {
                settings = {
                  extra-experimental-features = [
                    "nix-command"
                    "flakes"
                  ];
                  substituters = ["https://cosmic.cachix.org/"];
                  trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
                };
                gc = {
                  automatic = true;
                  dates = "weekly";
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
                  packages = [inputs.whyfetch.packages.${pkgs.stdenv.system}.whyfetch];
                };
              };
            };
          }
        ];
      specialArgs = {
        inherit inputs hostname;
      };
    };
in {
  mkMachines = machines: builtins.mapAttrs (_: v: mkMachine v) machines;
}
