{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xanadul";
  home.homeDirectory = "/home/xanadul";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

		# Language Servers
		# For servers see:  https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
		# And: https://mason-registry.dev/registry/list
		pkgs.nushell
		pkgs.carapace
		pkgs.ruff #Python code analysis
		pkgs.pyright #Python suggestions
		pkgs.lua-language-server
		pkgs.jdt-language-server
		pkgs.nil #Nix
		pkgs.zls #zig
		pkgs.clang-tools #C
		pkgs.hyprls
		pkgs.nodePackages.bash-language-server
		pkgs.texlab
		# pkgs.texliveMedium
		pkgs.python312Packages.pylatexenc
		pkgs.ripgrep
		pkgs.flutter
		pkgs.ninja
		pkgs.brave
		pkgs.cava
		pkgs.pulsemixer
		pkgs.wally-cli
		pkgs.hyprlandPlugins.hy3
		pkgs.filezilla
		pkgs.silicon

		pkgs.wofi
		pkgs.hyprshot
		pkgs.gnuplot

		pkgs.pandoc
		pkgs.mrkd
		pkgs.groff
		pkgs.ghostscript
		pkgs.texliveFull
		pkgs.unar
		pkgs.xorg.xrandr

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
		# ".config/alacritty".source = ~/Git/dotfiles/dotconfig/alacritty;
		# ".config/btop".source = ~/Git/dotfiles/dotconfig/btop;
		# ".config/dunst".source = ~/Git/dotfiles/dotconfig/dunst;
		# ".config/fastfetch".source = ~/Git/dotfiles/dotconfig/fastfetch;
		# ".config/hypr".source = ~/Git/dotfiles/dotconfig/hypr;
		# ".config/kitty".source = ~/Git/dotfiles/dotconfig/kitty;
		# ".config/mpv".source = ~/Git/dotfiles/dotconfig/mpv;
		# # ".config/nvim".source = ~/Git/dotfiles/dotconfig/nvim;
		# ".config/qt5ct".source = ~/Git/dotfiles/dotconfig/qt5ct;
		# ".config/qt6ct".source = ~/Git/dotfiles/dotconfig/qt6ct;
		# ".config/qutebrowser".source = ~/Git/dotfiles/dotconfig/qutebrowser;
		# ".config/rofi".source = ~/Git/dotfiles/dotconfig/rofi;
		# ".config/Vieb".source = ~/Git/dotfiles/dotconfig/Vieb;
		# ".config/waybar".source = ~/Git/dotfiles/dotconfig/waybar;
		# ".config/wezterm".source = ~/Git/dotfiles/dotconfig/wezterm;
		# ".config/yazi".source = ~/Git/dotfiles/dotconfig/yazi;
		# ".config/tessen".source = ~/Git/dotfiles/dotconfig/tessen;
		# ".zshrc".source = ~/Git/dotfiles/dotconfig/zsh/zshrc;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

	programs.git = {
		enable = true;
		userName = "Xanadul";
		userEmail = "xanadul@protonmail.com";
	};


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/xanadul/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
