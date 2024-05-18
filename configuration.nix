# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Soft and hard max on stored generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Backlight controller
  programs.light.enable = true;

  # Audio services
  hardware.pulseaudio.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };


  networking.hostName = "max"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enabling NAS Shares
  fileSystems."/Mallory" = {
    device = "192.168.0.14:/Mallory";
    fsType = "nfs";
  };


  fileSystems."/Public" = {
    device = "192.168.0.14:/Public";
    fsType = "nfs";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  system.autoUpgrade.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = 
  {
    mallory-swarm = {
      isNormalUser = true;
      description = "work account";
      extraGroups = [ "networkmanager" "wheel" "audio" "video"];
      packages = with pkgs; [
        # This account exists so I don't touch google while messing around
        slack
        vscode
      ];
    };
    mallory = {
      isNormalUser = true;
      description = "Mallory Mable";
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "vboxusers" ];
      packages = with pkgs; [
        # 3-D printing tool
        cura
      ];
    };
  };

  # Wayland windows manager
  programs.sway.enable = true;
  #  programs.i3status-rust.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtual Machine tool
  virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "mallory" ];

  # Fonts used for their icon packages
  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"]; })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Text editor 
    neovim
    # Wayland clipboard
    wl-clipboard
    # File explorer
    ranger
    # Version control
    git
    # Good terminal
    konsole
    # Status bar
    i3status-rust
    # C compiler
    gcc
    # C LSP
    clang-tools
    # Python
    python3
    # Rust
    rustc
    cargo
    # Rust lsp tool
    rust-analyzer
    # Network tool(s)
    nfs-utils
    # Password Manager
    kpcli
    # Tools that use the internet
    firefox
    gh
    signal-desktop
    discord
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
  system.stateVersion = "23.05"; # Did you read the comment?

}
