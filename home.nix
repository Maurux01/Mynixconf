{ config, pkgs, ... }:
{
  home.username = "tu_usuario";
  home.homeDirectory = "/home/tu_usuario";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };
  programs.rofi = {
    enable = true;
    theme = "catppuccin-mocha";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      font = "JetBrainsMono Nerd Font 12";
    };
  };
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono Nerd Font 12";
        frame_color = "#a6adc8";
        separator_color = "#a6adc8";
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
    };
  };
  services.picom.enable = false; # Managed at system level
  services.copyq = {
    enable = true;
    autostart = true;
  };
  services.network-manager-applet.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      name = "Catppuccin-Mocha";
      package = pkgs.catppuccin-qt5ct;
    };
  };
  xsession = {
    enable = true;
    windowManager.command = "i3";
    initExtra = ''
      nm-applet &
      copyq &
    '';
  };
  home.packages = with pkgs; [
    catppuccin-gtk
    catppuccin-cursors
    catppuccin-qt5ct
    catppuccin-qt6ct
    papirus-icon-theme
    nerdfonts
  ];
}
