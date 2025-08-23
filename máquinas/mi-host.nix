{ config, pkgs, ... }:
{
  imports = [
    ../módulos/i3.nix
    ../módulos/tema-catppuccin.nix
    ../módulos/servicios.nix
  ];

  networking.hostName = "mi-host";
  time.timeZone = "America/Bogota";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";
  users.users.tu_usuario = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
