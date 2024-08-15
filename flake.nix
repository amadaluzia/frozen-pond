{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    parts.url = "github:hercules-ci/flake-parts";
    pankomacs.url = "git+https://codeberg.org/amadaluzia/pankomacs.git";
    whyfetch.url = "git+https://codeberg.org/amadaluzia/whyfetch.git";
    nixstart.url = "git+https://codeberg.org/amadaluzia/nixstart.nvim.git";
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
  };

  outputs =
    inputs:
    let
      inherit (import ./hosts/lib.nix { inherit inputs overlays; }) mkHosts;
      overlays = import ./overlays { inherit inputs; };
    in
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake = let
        hosts = mkHosts [
          {
            hostname = "freguson";
            username = "amadal";
            system = "x86_64-linux";
            extraModules = [
              inputs.cosmic.nixosModules.default
	      {
                nix.settings = {
                  substituters = [ "https://cosmic.cachix.org/" ];
                  trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };
              }
            ];
          }
        ];
      in
      hosts;

      perSystem =
        { pkgs, system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
          devShells.default = pkgs.mkShell { packages = builtins.attrValues { inherit (pkgs) nil statix; }; };

          formatter = pkgs.nixfmt-rfc-style;
          # as soon as i set up treefmt i am removing this, cant be arsed rn
        };
    };
}
