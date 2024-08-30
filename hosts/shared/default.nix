{ lib, ... }: {
  options.frozen-pond = {
    desktop = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "kde" "sway" "qtile" "cosmic" ]);
      default = "sway";
      description = "Selects the GUI environment to use.";
    };
  };

  imports = [
    ./fonts.nix
    ./grub.nix
    ./pipewire.nix
    ./tty.nix
    ./sway.nix
    ./kde.nix
    ./git.nix
    ./chromium.nix
    ./emacs.nix
    ./vesktop.nix
    ./wezterm.nix
    ./gpg.nix
    ./direnv.nix
    ./polkit.nix
    ./virtualisation.nix
    ./cosmic.nix
    ./starship.nix
    ./xonsh.nix
    ./qtile.nix
    ./neovim.nix
    ./niri.nix
    ./eww.nix
    ./aliases.nix
    ./gtk.nix
  ];
}
