{ inputs, config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

time.timeZone = "Europe/Berlin";

i18n.defaultLocale = "en_GB.UTF-8";

i18n.extraLocaleSettings = {
  LC_ADDRESS = "en_GB.UTF-8";
  LC_IDENTIFICATION = "de_DE.UTF-8";
  LC_MEASUREMENT = "de_DE.UTF-8";
  LC_MONETARY = "de_DE.UTF-8";
  LC_NAME = "de_DE.UTF-8";
  LC_NUMERIC = "de_DE.UTF-8";
  LC_PAPER = "de_DE.UTF-8";
  LC_TELEPHONE = "de_DE.UTF-8";
  LC_TIME = "de_DE.UTF-8";
};

# Configure console keymap
console.keyMap = "de";

boot.supportedFilesystems = [ "zfs" ];
boot.zfs.forceImportRoot = false;
networking.hostId = "f81a04b9";
#for zfs-native mountpoints:  Properly imports Yukino, and should theoretically mount, but doesn't mount
#boot.zfs.extraPools = [ "Yukino" ];
#systemd.services.zfs-mount.enable = false;

#for zfs-legacy mountpoints (like fstab):
fileSystems."/mnt/Yukino" = {
  device = "Yukino";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data" = {
  device = "Yukino/Data";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Backups" = {
  device = "Yukino/Data/Backups";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media" = {
  device = "Yukino/Data/Media";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Anime" = {
  device = "Yukino/Data/Media/Anime";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Anime/Ecchi" = {
  device = "Yukino";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Appstuff" = {
  device = "Yukino/Data/Media/Appstuff";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Documents" = {
  device = "Yukino/Data/Media/Documents";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Downloads" = {
  device = "Yukino/Data/Media/Downloads";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Music" = {
  device = "Yukino/Data/Media/Music";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/NSFW" = {
  device = "Yukino/Data/Media/NSFW";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/Pictures" = {
  device = "Yukino/Data/Media/Pictures";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Media/TV" = {
  device = "Yukino/Data/Media/TV";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/Nextcloud" = {
  device = "Yukino/Data/Nextcloud";
  fsType = "zfs";
};
fileSystems."/mnt/Yukino/Data/University" = {
  device = "Yukino/Data/University";
  fsType = "zfs";
};

# Enable networking
networking.networkmanager.enable = true;
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

networking.hostName = "nixos"; # Define your hostname.
networking.extraHosts =
  ''
    100.71.109.130 hanako.ts
  '';

# Enable the OpenSSH daemon.
# services.openssh.enable = true;
services.tailscale.enable = true;

#Samba
services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
services.samba = {
  enable = true;
  securityType = "user";
  extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.1. 127.0.0.1 localhost
    hosts deny = 0.0.0.0/0
    guest account = nobody
    map to guest = bad user
  '';
  shares = {
    anime = {
      path = "/mnt/Yukino/Data/Media/Anime";
      browseable = "yes";
      "read only" = "yes";
      "guest ok" = "no";
      "valid users" = "xanadul";
    };
  };
};

networking.firewall.enable = true;

networking.firewall.allowedTCPPorts = [
  3080 #Git/Gogs
  445 #SMB-Files
  5357 # wsdd
  32774 # nginx.legion774.net
];

networking.firewall.allowedUDPPorts = [ 
  41641
  3702 # wsdd
];

networking.firewall.checkReversePath = "loose";

# Enable sound with pipewire.
sound.enable = true;
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

# Enable the X11 windowing system.
services.xserver.enable = true;

# Enable the KDE Plasma Desktop Environment.
services.xserver.displayManager.sddm.enable = true;
services.xserver.desktopManager.plasma5.enable = true;

#programs.sway.enable = true;
# Configure keymap in X11
services.xserver = {
  layout = "de";
  xkbVariant = "";
};

programs.hyprland = {
  enable = true;
};
programs.waybar = {
  enable = true;
  package = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });
};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;


xdg.portal.enable = true;

programs.steam = {
  enable = true;
  remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = false; # Opens ports in the firewall for Source Dedicated Server
};
nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
          libgdiplus
        ]);
      });
    })
  ];
programs.java.enable = true;

# Enable CUPS to print documents.
services.printing.enable = true;

services.flatpak.enable = true;

programs.zsh.enable = true;
#users.defaultUserShell = pkgs.zsh;

# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
  bash
  libsForQt5.qtstyleplugin-kvantum
  libsForQt5.qt5ct
  dracula-theme
  vim
  lsd
  lf
  ydotool
  neovim
  wget
  btop
  killall
  shadow

  rlwrap
  mpv
  mpvc

  git
  emacs
  ripgrep
  coreutils
  fd
  clang

  vieb
  nodejs_20
  rofi-wayland
  rofi-calc
  rofi-emoji
  libqalculate
  
  zsh
  wtype
  gnupg
  pinentry-curses
  pinentry
  pinentry-rofi
  pinentry-qt
  tailscale

  steam
  steam-run # needed for steam games 
  #(steam.override { withJava = true; })

  emacs-all-the-icons-fonts

  docker
  docker-compose
  crun
];

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.xanadul = {
  isNormalUser = true;
  description = "xanadul";
  extraGroups = [ "networkmanager" "wheel"];

packages = with pkgs; [
    qutebrowser
    firefox
    kate
    libnotify
    dunst

    #rofi
    tessen
    wl-clipboard
    cliphist
    wf-recorder
    pass-wayland
    slurp
    grim
    swaybg
    pamixer
    themechanger
    alacritty
    wezterm
    kitty
    lxde.lxsession
    jetbrains-mono
    jq
    cmake
    gnumake
    gcc
    python3
    telegram-desktop
    protonup-qt
    lutris
    thunderbird

    emacsPackages.lsp-dart
    emacsPackages.dart-server
    emacsPackages.dart-mode
    emacsPackages.flutter
    emacsPackages.lsp-pyright

    flutter
    dart


    jetbrains-mono
    ubuntu_font_family
    emacsPackages.vterm

    minetest #FOSS engine for Voxel-Games

    #distrobox #I admit, it's great to use when NixOS is confusing me
  ];
};

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
programs.gnupg.agent = {
  enable = true;
  pinentryFlavor = "qt";
  enableSSHSupport = true;
};
services.pcscd.enable = true;

virtualisation.docker.enable = true;
#virtualisation.docker.defaultNetwork.settings.dns_enabled = true;

#virtualisation.podman = {
#  enable = true;
#  #dockerCompat = true;
#  defaultNetwork.settings.dns_enabled = true;
#};

system.stateVersion = "23.05";
}
