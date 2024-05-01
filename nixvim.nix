{ config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.catppuccin.enable = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    keymaps = [
      # {
      #   key = ";";
      #   action = ":";
      # }
      # {
      #   mode = "n";
      #   key = "<leader>m";
      #   options.silent = true;
      #   action = "<cmd>!make<CR>";
      # }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}