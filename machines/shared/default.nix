{
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.frozen-pond = {
    desktop = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "kde"
          "sway"
          "qtile"
          "cosmic"
          "niri"
        ]
      );
      default = null;
      description = "Selects the GUI environment to use.";
    };
  };

  config = lib.mkMerge [
    {
      systemd.tmpfiles.rules = let
        wallpaper = "${inputs.walls.packages.${pkgs.system}.catppuccin}/share/wallpapers/catppuccin/01.png";
      in ["L+ /tmp/wallpaper 0644 - - - ${wallpaper}"];
    }
  ];

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
    ./socials.nix
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
    ./qutebrowser.nix
    ./misc.nix
    ./waybar.nix
    ./fuzzel.nix
    ./mako.nix
    ./nyxt.nix
    ./users.nix
    ./foot.nix
  ];
}
