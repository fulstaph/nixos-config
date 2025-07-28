{ config, pkgs, ... }:
{
  programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrains Mono";
            style = "Regular";
          };
          size = 12.0;
        };
        colors = {
          primary = {
            background = "0x1e1e2e";
            foreground = "0xcdd6f4";
          };
          normal = {
            black = "0x1e1e2e";
            red = "0xf38ba8";
            green = "0xa6e3a1";
            yellow = "0xf9e2af";
            blue = "0x89b4fa";
            magenta = "0xf5c2e7";
            cyan = "0x94e2d5";
            white = "0xcdd6f4";
          };
          bright = {
            black = "0x45475a";
            red = "0xf38ba8";
            green = "0xa6e3a1";
            yellow = "0xf9e2af";
            blue = "0x89b4fa";
            magenta = "0xf5c2e7";
            cyan = "0x94e2d5";
            white = "0xcdd6f4";
          };
        };
      };
    };
}