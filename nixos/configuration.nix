{ config, pkgs, ... }:

let
  vars = import ./variables.nix;
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Server share mounting logic
      ./samba
    ];

  # Checks once a week to take out the trash
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      configurationLimit = 20; # how many NixOS generations to keep in menu
    };
    efi.canTouchEfiVariables = true;
  };

  # For dual boot clock issue(now both systems expect system clock to be on local time)
  time.hardwareClockInLocalTime = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.hostName = vars.hostName; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = vars.timeZone;

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
    "${vars.coreUser}" = {
      isNormalUser = true;
      description = "Mallory Mable";
      extraGroups = [ "networkmanager" "wheel" "audio" "video" "tss" "vboxusers"];
      packages = import ./packages/desktop.nix { inherit pkgs; };
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
    # Rust based implementation of GREP
    ripgrep
    # Wayland clipboard
    wl-clipboard
    # Wayland screenshot utility
    grim
    # Version control
    git
    # Status bar
    waybar

    ## Compilers, Language Servers, and Linters
    # C compiler
    gcc
    # Debugger
    gdb
    # C lsp
    clang-tools
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
    # Lua lsp
    lua-language-server
    # Python
    python3
    # Python lsp
    python3Packages.jedi-language-server
    # TS/JS lsp
    deno
    # JS, TS, JSON, CSS linting
    biome
    # HTML template linter
    djlint

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

  services = {
    # Music player working from the music directory of the mounted media server
    mpd = {
      enable = true;
      user = "${vars.coreUser}";
      settings = {
        music_directory = "/mnt/media/Music/";
        audio_output = [{
          type = "pulse";
          name = "Pulse Output";
          server = "unix:/run/user/${vars.uid}/pulse/native";
        }];
      };
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
