{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraSessionCommands = ''
      export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark
      export QT_QPA_PLATFORMTHEME=qt5ct
      export QT_STYLE_OVERRIDE=Catppuccin-Mocha
    '';
  };
  services.picom.enable = true;
  services.picom.backend = "glx";
  services.picom.vSync = true;
  services.picom.settings = {
    shadow = true;
    shadow-radius = 12;
    shadow-opacity = 0.5;
    shadow-offset-x = -8;
    shadow-offset-y = -8;
    blur-background = true;
    inactive-opacity = 0.95;
    active-opacity = 1.0;
    frame-opacity = 0.9;
    corner-radius = 8;
  };
  environment.systemPackages = with pkgs; [
    kitty
    rofi
    dunst
    copyq
    networkmanagerapplet
    lxappearance
    qt5ct
    qt6ct
    catppuccin-gtk
    catppuccin-cursors
    catppuccin-qt5ct
    catppuccin-qt6ct
  ];
  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  # Enable sound, networking, etc.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  networking.networkmanager.enable = true;
  # Optional: enable printing
  services.printing.enable = true;
}
