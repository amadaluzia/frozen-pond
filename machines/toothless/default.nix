{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./disks.nix
  ];

  frozen-pond = {
    desktop = "niri";
    emacs.enable = true;
    wezterm.enable = true;
    fonts.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    git.enable = true;
    pipewire.enable = true;
    socials.element = true;
    polkit.enable = true;
    virtualisation.enable = true;
    starship.enable = true;
    neovim.enable = true;
    eww.enable = true;
    qutebrowser.enable = true;
    nyxt.enable = true;
    misc.sudo_prompt = true;
  };

  boot.loader = {
    efi.canTouchEfiVariables = false;
    systemd-boot = {
      enable = true;
      editor = true;
      memtest86.enable = true;
      consoleMode = "max";
    };
  };

  xdg.mime.defaultApplications = {
    "text/html" = [
      "org.qutebrowser.qutebrowser.desktop"
      "nyxt.desktop"
      "chromium-browser.desktop"
    ];
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

  i18n.defaultLocale = "en_GB.UTF-8";

  services.xserver.deviceSection = ''
    Option "VariableRefresh" "true"
  '';

  environment.systemPackages = [pkgs.wget];

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # its mutable but its better to leave it as is
  system.stateVersion = "24.05";
}
