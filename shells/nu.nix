{ config, pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    configFile = ./config.nu;
  };
}