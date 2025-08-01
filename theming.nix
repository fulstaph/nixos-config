{ pkgs, ... }: 

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-BL";
      package = pkgs.tokyonight-gtk-theme; # Correct package name
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  # Qt configuration for consistency
  qt = {
    enable = true;
    platformTheme.name = "gtk3"; # Updated syntax
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  home.packages = with pkgs; [
    # Theme packages
    tokyonight-gtk-theme
    papirus-icon-theme
    bibata-cursors
    
    # Qt styling
    adwaita-qt
    qt5.qtwayland
    qt6.qtwayland
  ];

  # Optional: Set environment variables for consistency
  home.sessionVariables = {
    GTK_THEME = "Tokyonight-Dark-BL";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };
}