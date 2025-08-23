{ config, pkgs, ... }:
{
  home.username = "tu_usuario";
  home.homeDirectory = "/home/tu_usuario";

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font.name = "JetBrainsMono Nerd Font";
    font.size = 12;
  };

  programs.rofi = {
    enable = true;
    theme = "catppuccin-mocha";
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#a6e3a1";
        separator_color = "frame";
        font = "JetBrainsMono 10";
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
    };
  };

  services.copyq.enable = true;

  home.packages = with pkgs; [
    catppuccin-gtk
    catppuccin-cursors
    catppuccin-kvantum
    flameshot
    feh
  ];

  xsession.windowManager.i3.config = {
    # Autostart
    startup = [
      { command = "nm-applet"; }
      { command = "copyq"; }
      { command = "picom"; }
      { command = "dunst"; }
      { command = "flameshot"; }
    ];
    # Keybindings (mod = Mod4/Super)
    keybindings = {
      "Mod4+Return" = "exec kitty";
      "Mod4+d" = "exec rofi -show drun";
      "Mod4+Shift+q" = "kill";
      "Mod4+Shift+r" = "restart";
      "Mod4+Shift+e" = "exec --no-startup-id i3-msg exit";
      "Mod4+f" = "fullscreen toggle";
      "Mod4+Left" = "focus left";
      "Mod4+Down" = "focus down";
      "Mod4+Up" = "focus up";
      "Mod4+Right" = "focus right";
      "Mod4+Shift+Left" = "move left";
      "Mod4+Shift+Down" = "move down";
      "Mod4+Shift+Up" = "move up";
      "Mod4+Shift+Right" = "move right";
      "Mod4+l" = "exec i3lock";
      "Print" = "exec flameshot gui";
    };
    # Catppuccin colors
    colors = {
      background = "#1e1e2e";
      focused = {
        border = "#89b4fa";
        background = "#313244";
        text = "#cdd6f4";
        indicator = "#a6e3a1";
        childBorder = "#89b4fa";
      };
      unfocused = {
        border = "#313244";
        background = "#1e1e2e";
        text = "#a6adc8";
        indicator = "#45475a";
        childBorder = "#313244";
      };
    };
  };
}
