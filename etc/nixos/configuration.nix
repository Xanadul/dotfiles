# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # ZFS
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "9358235d"; #Apparently, zfs needs a hostId...
  boot.zfs.extraPools = [ "Yukino" ];

  networking.hostName = "hanako-nixos"; # Define your hostname.
	
  networking.extraHosts =
    ''
      100.92.39.66 hanako.ts
    '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 53317 22 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
			{ from = 53317; to = 53317; } 
			{ from = 22; to = 22; } 
    ];
  };

	#Printing
	services.printing.drivers = [pkgs.gutenprint];
	services.printing.enable = true;
	hardware.printers = {
		ensurePrinters = [
			# {
			# 	name = "HP Officejet Pro 7720 Series";
			# 	location = "Home";
			# 	deviceUri = "hp:/net/OfficeJet_Pro_7720_series?ip=192.168.1.80";
			# 	model = "OfficeJet_Pro_7720_series";
			# }
			{
				name = "PIXMA-iP300x";
				location = "Home";
				deviceUri = "usb://Canon/iP3000?serial=12B4F8";
				model = "gutenprint.5.3://bjc-PIXMA-iP3000/expert Canon PIXMA iP3000 - CUPS+Gutenprint v5.3.4";
			}
		];
	};

	# Graphics driver

  # Tailscale
  services.tailscale.enable = true;

  virtualisation.docker.enable = true;
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;

  services.samba = {
    enable = true;
		settings = {
			global = {
				"security" = "user";
				"workgroup" = "WORKGROUP";
			};
			"Anime" = {
				"path" = "/mnt/Yukino/Data/Media/Anime";
				"browsable" = "yes";
				"read only" = "yes";
				"guest ok" = "yes";
			};
			"NSFW" = {
				"path" = "/mnt/Yukino/Data/Media/NSFW/";
				"browsable" = "yes";
				"read only" = "yes";
				"guest ok" = "no";
			};
		};
    openFirewall = true;
  };
  services.samba-wsdd = { # Samba share discovery
    enable = true;
    openFirewall = true;
  };

  hardware.acpilight.enable = true;

	# For zsa keyboard tools and udev settings
	hardware.keyboard.zsa.enable = true;
  hardware.keyboard.qmk.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

	# ADB/Fastboot
	programs.adb.enable = true;

  # Desktops
	services.desktopManager.plasma6.enable = true;
	services.desktopManager.plasma6.notoPackage = pkgs.noto-fonts;
	programs.kdeconnect.enable = true;
  programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
	# Optional, hint electron apps to use wayland
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal.enable = true;
  services.displayManager = {
		enable = true;
    # gdm = {
    #   enable = true;
    #   banner = "Foo Bar";
    #   wayland = true;
    # };
    sddm = {
    	enable = true;
    	wayland.enable = true;
    	theme = "arch";
    };
  };

	# Theming
	qt.platformTheme = "qt5ct";

  #Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
		extraConfig.pipewire."92-low-latency" = {
			"context.properties" = {
				"default.clock.allowed-rates" = [ 44100 48000 88200 96000 ];
				"default.clock.quantum" = 256;
				"default.clock.min-quantum" = 128;
				"default.clock.max-quantum" = 2048;
			};
		};
  };
	services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
		context.modules = [
			{
				name = "libpipewire-module-protocol-pulse";
				args = {
					pulse.min.req = "128/48000";
					pulse.default.req ="256/48000";
					pulse.max.req = "2048/48000";
					pulse.min.quantum = "128/48000";
					pulse.max.quantum = "2048/48000";
				};
			}
		];
		stream.properties = {
			node.latency = "128/48000";
			resample.quality = 1;
		};
	};
  # Zsh
  programs.zsh = {
    enable = true;
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
    nerdfonts
  ];

  services.flatpak.enable = true;

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
		gamescopeSession.enable = true;
	};

  # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.stu216622 = {
		isNormalUser = true;
		description = "Stu216622";
		extraGroups = ["video" "wheel"];
		packages = with pkgs; [
			wezterm
		];
	};
	users.users.xanadul = {
			isNormalUser = true;
			description = "xanadul";
			extraGroups = [ "networkmanager" "wheel" "video" "docker" "adbusers"];
			packages = with pkgs; [

			# Media
			zathura
			mpv
			obs-studio
			ffmpeg
			yt-dlp
			krita
			blender
			# k3b
			nomacs

			# DE Tools
			xdragon #Though its not just for X
			kdePackages.plasma-systemmonitor
			waybar
			kdePackages.dolphin
			waybar
			wl-clipboard
			wtype
			slurp
			grim
			rofi-wayland
			pinentry
			pinentry-qt
			pavucontrol
			cliphist
			lxde.lxsession

			# CLI
			starship
			yazi
			eza
			dunst
			mako
			unzip
			unrar
			pass
			gopass
			# chafa #Terminal image viewer
			bat
			exiftool
			tg #Telegram TUI https://github.com/paul-nameless/tg
			fd
			brightnessctl
			# swww
			fastfetch
			# unimatrix
			# nvtopPackages.full
			# qmk

			# Theming
			dracula-theme
			themix-gui
			xfce.xfce4-settings
			lxappearance

			# Coding
			coreutils
			stylua
			python3
			cargo
			p7zip
			lesspipe
			emacs
			libdbusmenu-gtk3 #NOTE: Needed?
			dart-sass
			#Dart and flutter in home.nix, because darts lsp server is bundled with dart
			nodejs
			nodePackages.npm

			# Web
			firefox
			qutebrowser
			remmina
			vieb

			# GUI
			localsend
			telegram-desktop
			lutris
			thunderbird
			qalculate-qt
			qalculate-gtk
			xournalpp
			libreoffice-qt6

			# gaming
			protonup-qt
			gamemode
			prismlauncher

			# Other
			hugo

			# matugen
			# android-tools
			orca-slicer
			qmk
			usbutils
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
		libsForQt5.partitionmanager
		kdePackages.print-manager
		kdePackages.qtstyleplugin-kvantum #The actual kvantum GUI
		libsForQt5.qtstyleplugin-kvantum
		libsForQt5.qt5ct
		gparted
		lightly-boehs
		protonvpn-gui
		# mcelog #Logging util for faulty hardware
		networkmanager-fortisslvpn
    acpilight
		btrfs-progs
    pamixer
    jq
    vim
    kitty
    wezterm
    fzf
    git
    gcc
    cmake
    zig
    killall
		hyprland
		swaybg
		hyprpaper
		hyprlock
    xdg-desktop-portal-hyprland
    hyprland-protocols
    # hyprlandPlugins.hy3
		fastfetch
		btop
		libqalculate
		distrobox
		tree
		tre-command
		tldr
		# bat
		moar
		nix-index
		pmbootstrap
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
