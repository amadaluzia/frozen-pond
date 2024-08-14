{ pkgs, ... }: {
  imports = [
    ./hardware.nix
  ];
  
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
    vesktop.enable = true;
    polkit.enable = true;
    virtualisation.enable = true;
    starship.enable = true;
    i3.enable = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "GB";

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    neovim
    wget
  ];

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
