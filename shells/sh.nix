{ config, pkgs, ... }:
let
  myShellAliases = {
      ls = "eza --color=always --icons=always";
      ll = "ls -l";
      cat = "bat";
      ".." = "cd ..";
    }; 
in {
  programs.bash = {
    enable = true;
    shellAliases = myShellAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myShellAliases;
  };
}