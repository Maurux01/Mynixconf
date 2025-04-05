{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Bogota";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  users.users.tu_usuario = {
    isNormalUser = true;
    description = "Tu Nombre";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      vim
      neovim
      vscode
      cava
      spotify
      spotify-tui
      lazygit
      lazydocker
      docker
      emacs
      (emacsPackagesFor emacs).spacemacsPackages.base  # Spacemacs
    ];
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # LazyVim (se instalará por ti en Neovim más adelante, como configuración)
  # Puedes clonarlo desde: https://github.com/LazyVim/starter

  # Enable services
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable Flakes (opcional, recomendado)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
