{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Checks once a week to clear out any month old builds
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For dual boot clock issue(now both systems expect system clock to be on local time)
  time.hardwareClockInLocalTime = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.hostName = "machno"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "tss" "vboxusers"];
      packages = with pkgs; [
        # 3-D printing tool
        orca-slicer
        # CAD
        freecad-wayland
        # Media Player
        vlc
        # E-reader
        calibre
        # Chromium for nand IDE
        ungoogled-chromium
      ];
    };
  };

  systemd.tmpfiles.rules = [
    # Type  Path                Mode User Group Age  Argument
    "L+   /home/mallory/server  -    -    -     -   /mnt/omv-mallory"
    "L+   /home/mallory/media   -    -    -     -   /mnt/media"
  ];

  # Wayland windows manager
  programs.sway.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtual Machine tool
  virtualisation.virtualbox.host.enable = true;
  # boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

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
    # R stats enviroment
    R

    # Password Manager
    keepassxc
    # MPD Client
    mpc
    # Network tool(s)
    nfs-utils
    cifs-utils

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

  # SAMBA Server mounting logic
  fileSystems = let
    OMV_IP="10.0.1.9"; #NOTE: Change on move
    automount_opts = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=0"
    "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" "user" "users"
    "soft" "rsize=65536" "actimeo=60" "noatime"];
    mallory_creds = ["credentials=/etc/nixos/smb-secrets" "uid=1000" "gid=100"];
  in {
    "/mnt/media" = {
      device = "//${OMV_IP}/jellyfin";
      fsType = "cifs";
      options = automount_opts ++ mallory_creds;
      };

    "/mnt/omv-mallory" = {
      device = "//${OMV_IP}/mallory";
      fsType = "cifs";
      options = automount_opts ++ mallory_creds;
    };
  };

  services = {
    # Music player working from the music directory of the mounted media server
    mpd = {
      enable = true;
      user = "mallory";
      musicDirectory = "/mnt/media/Music/";
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
