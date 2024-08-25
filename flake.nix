{
  description = "Frozen Pond";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    pankomacs.url = "git+https://codeberg.org/amadaluzia/pankomacs.git";
    whyfetch.url = "git+https://codeberg.org/amadaluzia/whyfetch.git";
    nixstart.url = "git+https://codeberg.org/amadaluzia/nixstart.nvim.git";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgt = {
      url = "github:AdisonCavani/distro-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    f2k.url = "github:moni-dz/nixpkgs-f2k";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" ];
      overlays = (import ./overlays { inherit inputs; });
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system: f { pkgs = import nixpkgs { inherit system overlays; }; }
        );
      inherit (import ./hosts/lib.nix { inherit inputs overlays; }) newNixosSystem;
      treefmtEval = forAllSystems ({ pkgs }: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      nixosConfigurations = {
        freguson = newNixosSystem {
          hostname = "freguson";
          username = "amadal";
          system = "x86_64-linux";
          extraModules = [
            inputs.cosmic.nixosModules.default
            inputs.niri.nixosModules.niri
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
          ];
        };
      };

      overlays.default = overlays;
      packages = forAllSystems ({ pkgs }: import ./pkgs pkgs);
      devShells = forAllSystems (
        { pkgs }:
        {
          default = pkgs.callPackage ./shell.nix { };
        }
      );
      formatter = forAllSystems ({ pkgs }: treefmtEval.${pkgs.system}.config.build.wrapper);
    };
}
