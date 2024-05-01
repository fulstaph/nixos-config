{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      character = {
        success_symbol = "[λ](pink)";
        error_symbol = "[λ](bold red)";
      };

      format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_status$directory$character";
      # shlvl = {
      #   disabled = false;
      #   symbol = "λ";
      #   style = "bright-red bold";
      # };

      package.disabled = true;
    };
  };
}