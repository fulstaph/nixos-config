{ config, lib, pkgs, ... }:

{
  imports = [
    ./theming.nix

    ./shells/sh.nix
    ./shells/starship.nix
    ./shells/nu.nix
    ./shells/tmux.nix
    ./shells/zellij.nix

    ./cli/bat.nix
    ./cli/eza.nix
    ./cli/git.nix

    ./applications/terminals/wezterm.nix
    ./applications/terminals/alacritty.nix
    ./applications/editors/helix.nix
    ./applications/editors/zed.nix
    ./applications/waybar.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fulstaph";
  home.homeDirectory = "/home/fulstaph";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  services.blueman-applet.enable = true;

  systemd.user.services = {
    xwayland-satellite = {
      Unit = {
        Description = "XWayland satellite";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target" "niri.service"];
      };
      Service = {
        ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    swaybg = {
      Unit = {
        Description = "Wallpaper daemon";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i /home/fulstaph/.config/wallpapers/main.jpg -m fill";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock"; }
      { timeout = 600; command = "systemctl suspend"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock"; }
    ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      indicator = true;
      effect-blur = "7x3";
      effect-vignette = "0.5:0.5";
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  programs.alacritty.enable = true; # Super+T in the default setting (terminal)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  # programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.mako.enable = true; # notification daemon
  # services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

  # fonts
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "FiraCode Nerd Font" ];
  };

  home.packages = with pkgs; [
    kitty
    swaybg
    brightnessctl
    playerctl
    btop
    ripgrep
    fastfetch
    drawio
    wofi

    # Fonts
    fantasque-sans-mono
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    fira-code
    font-awesome

    adwaita-icon-theme

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    qbittorrent
    vscode
    telegram-desktop
    discord
    vlc
    go
    gcc
    cargo
    rustc
    rust-analyzer

    obsidian
    bitwig-studio

    # work?
    microsoft-edge
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # Deploy userChrome.css for Firefox
    "/home/fulstaph/.mozilla/firefox/fulstaph/chrome/userChrome.css".text = ''
      /* Hide the horizontal tab bar */
      #TabsToolbar { visibility: collapse !important; }
      '';

    ".config/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
      enable = true;
    };

    ".config/wofi" = {
      source = ./applications/wofi;
      recursive = true;
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    config.common = {
      default = ["gnome"];
      "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fulstaph/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "${pkgs.nushell}/bin/nu";
    # SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.nvf = {
    enable = true;
    settings = {
      # vim.viAlias = false;
      # vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
      };
    };
  };

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    [main]
    font=Monospace:size=5
    dpi-aware=yes
    prompt=❯
    icon-theme=Adwaita
    fields=name,generic,comment,categories,filename,keywords
    show-actions=yes
    width=20
    height=50

    [colors]
    background=1a1b26ff
    text=c0caf5ff
    selection=33467Cff
    selection-text=c0caf5ff
    selection-match=ff9e64ff
    border=1a1b26ff
    match=7aa2f7ff

    [border]
    width=5
    radius=20
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
