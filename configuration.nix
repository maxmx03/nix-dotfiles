# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./config-nix/hyprland.nix
    ./config-nix/tmux.nix
    ./config-nix/audio.nix
    ./config-nix/fonts.nix
  ];

  # Bootloader.
  boot.initrd.kernelModules = ["amdgpu"];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = ["nodev"];
      efiSupport = true;
      enable = true;
      useOSProber = true;
    };
  };
  time.hardwareClockInLocalTime = true;

  networking.hostName = "milianor"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };
  security.rtkit.enable = true;
  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.milianor = {
    isNormalUser = true;
    description = "milianor";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      vscode
      github-desktop
      google-chrome
      pavucontrol
      pamixer
      vim
      eza
      cmus
      mpv
    ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "milianor";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    dunst
    mako
    jq
    xdg-utils
    unzip
    unrar
    yarn
    fd
    fzf
    bat
    ripgrep
    # lsp-servers
    lua-language-server
    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    typescript
    nodePackages.pyright
    nixd
    # formatters
    black
    prettierd
    alejandra
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable Amd drivers
  services.xserver.videoDrivers = ["amdgpu"];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
