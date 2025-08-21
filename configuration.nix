{ config, pkgs, ... }:
  tmux
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
      onlyoffice-bin    # Added ONLYOFFICE
      masterpdfeditor   # Added Master PDF Editor
      # Paquetes útiles para i3 y Hyprland
      dmenu
      i3status
      
      kitty
      waybar
      rofi-wayland
    ];
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # LazyVim (se instalará por ti en Neovim más adelante, como configuración)
  # Puedes clonarlo desde: https://github.com/LazyVim/starter


  # Habilita X11 y Plasma5
  # Drivers de video (ajusta según tu hardware: "nvidia", "amdgpu", "intel")
  services.xserver.videoDrivers = [ "modesetting" ];

  # Soporte para touchpad (laptops)
  services.xserver.libinput.enable = true;

  # Variables de entorno para QT y GTK
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GTK_THEME = "Adwaita:dark";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # Utilidades para portapapeles y screenshots
  environment.systemPackages = with pkgs; [
  # Portapapeles
  cliphist
  clipmenu
  # Notificaciones
  mako
  # Fondos de pantalla
  swaybg
  feh
  # Bloqueo de pantalla
  swaylock
  i3lock
  # Energía y discos
  udiskie
  acpi
  powertop
  tlp
  # Redes y Bluetooth
  networkmanagerapplet
  blueman
  # Terminal moderno extra
  foot
  # Audio
  pavucontrol
  # Emojis y fuentes extra
  noto-fonts-emoji
  nerdfonts
  cascadia-code
  corefonts
  # Soporte para impresoras
  services.printing.enable = true;

  # Soporte para firewall
  networking.firewall.enable = true;

  # Soporte para Flatpak
  services.flatpak.enable = true;

  # Soporte para actualizaciones automáticas
  system.autoUpgrade.enable = true;

  # Soporte para compartir archivos con Windows (Samba)
  services.samba.enable = true;
    # ...existing code...
    wl-clipboard
    xclip
    grim
    slurp
    flameshot
  ];

  # Soporte Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  # Habilita i3 como gestor de ventanas X11
  services.xserver.windowManager.i3.enable = true;

  # Habilita Hyprland (Wayland)
  programs.hyprland.enable = true;

  # Cambia LightDM por greetd + tuigreet para selección de sesión
  services.xserver.displayManager.lightdm.enable = false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "tuigreet --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions:/run/current-system/sw/share/plasma/sessions";
        user = "greeter";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    tuigreet
    playerctl
    pamixer
    brightnessctl
    libnotify
    dunst
    noto-fonts
    font-awesome
    papirus-icon-theme
    lxappearance
    qt5ct
    qt6ct
  ];

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable Flakes (opcional, recomendado)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
