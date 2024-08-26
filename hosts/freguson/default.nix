{ pkgs, ... }:
{
  imports = [ ./hardware.nix ];

  frozen-pond = {
    sway.enable = true;
    emacs.enable = true;
    wezterm.enable = true;
    fonts.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    git.enable = true;
    gpg.enable = true;
    grub.enable = true;
    pipewire.enable = true;
    # vesktop.enable = true;
    polkit.enable = true;
    virtualisation.enable = true;
    starship.enable = true;
    qtile.enable = true;
    neovim.enable = true;
    eww.enable = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "GB";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.deviceSection = ''
    Option "VariableRefresh" "true"
  '';

  environment.systemPackages = [ pkgs.wget ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # its mutable but its better to leave it as is
  system.stateVersion = "24.05";
}
