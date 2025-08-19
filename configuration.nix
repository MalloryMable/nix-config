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

  # Enables TPM 2
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
    tctiEnvironment.enable = true;
  };

  # Backlight controller
  programs.light.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.hostName = "machno"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
    mallory = {
      isNormalUser = true;
      description = "Mallory Mable";
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "vboxusers" "tss"];
      packages = with pkgs; [
        # 3-D printing tool
        orca-slicer
        # CAD
        freecad-wayland
        # Media Player
        vlc
        # E-reader
        calibre
      ];
    };
  };

  # Wayland windows manager
  programs.sway.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtual Machine tool
  virtualisation.virtualbox.host.enable = true;

  # Fonts used for their icon packages
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.symbols-only
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Alternative terminal
    wezterm
    # Text editor
    neovim
    # Menu for starting apps
    dmenu-rs
    # Wayland clipboard
    wl-clipboard
    # Wayland screenshot utility
    grim
    # File explorer
    ranger
    # Version control
    git
    # Status bar
    waybar

    ## Compilers and Language Servers
    # C compiler
    gcc
    # C lsp
    clang-tools
    # Python
    python3
    # Lua lsp
    lua-language-server
    # Rust toolchain
    rustc
    cargo
    # Rust lsp
    rust-analyzer
    # LaTeX Build tools
    texliveFull
    # LaTeX lsp
    texlab

    # Password Manager
    keepassxc
    # MPD Client
    mpc
    # Network tool(s)
    nfs-utils
    # Tools that use the internet
    firefox
    gh
    signal-desktop
    discord
  ];


  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services = {
    # Enables VPN Client
    tailscale.enable = true;
    # Music player set up for the user 'mallory' when mounting from a "omv NAS"
    mpd = {
      enable = true;
      user = "mallory";
      musicDirectory = "/home/mallory/mnt/omv/Music/";
      extraConfig = ''
        audio_output {
          type "pulse"
          name "Pulse Output"
          server "unix:/run/user/1000/pulse/native"
        }
      '';
      startWhenNeeded = true;
    };
    # Enable the OpenSSH daemon.
    # openssh.enable = true;
  };

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
