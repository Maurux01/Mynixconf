{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.flatpak.enable = true;
  networking.firewall.enable = true;
  system.autoUpgrade.enable = true;
}
