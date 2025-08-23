{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];

  environment.systemPackages = with pkgs; [
    kitty rofi dunst picom copyq networkmanagerapplet
    feh flameshot lxappearance papirus-icon-theme
    fontconfig jetbrains-mono nerdfonts
  ];
}
