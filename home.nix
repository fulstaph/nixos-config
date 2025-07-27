{ config, lib, pkgs, ... }:

let
  inNiri = builtins.getEnv "XDG_SESSION_DESKTOP" == "niri";
in
{
  imports = [
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  programs.alacritty.enable = true; # Super+T in the default setting (terminal)
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  home.packages = with pkgs; [
    kitty
    swaybg

    # Install Nerd Fonts with a limited number of fonts
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    vscode
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
    # SHELL = "${pkgs.nushell}/bin/nu";
    SHELL = "${pkgs.zsh}/bin/zsh";
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

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
