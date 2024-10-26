{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "George Kvaratskhelia";
    userEmail = "fulstaph@gmail.com";
  };
}