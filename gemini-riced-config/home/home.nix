
{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Catppuccin theme
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
  catppuccin = {
    enable = true;
    flavour = "mocha";
    accent = "mauve";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Packages to install
  home.packages = with pkgs; [
    # GUI
    kitty
    firefox
    dunst
    rofi-wayland # Rofi for X11 is also pulled in by i3 config
    wofi # Launcher for wayland
    polybar

    # CLI
    neovim
    fish
    starship
    zoxide
    bat
    exa
    fd
    ripgrep
    lazygit

    # Wayland specific
    swww # Wallpaper daemon
    wlogout # Logout menu
    wl-clipboard # Clipboard tool
    
    # Hyprland utils
    hyprpaper
    hyprpicker # color picker
  ];

  # Shell config
  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting
      zoxide init fish | source
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Set fish as default shell
  users.defaultUserShell = pkgs.fish;

  # Git config
  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "your@email.com";
  };

  # Link dotfiles
  home.file = {
    ".config/hypr" = {
      source = ./dotfiles/hypr;
      recursive = true;
    };
    ".config/i3" = {
      source = ./dotfiles/i3;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };
    ".config/kitty" = {
      source = ./dotfiles/kitty;
      recursive = true;
    };
    ".config/dunst" = {
      source = ./dotfiles/dunst;
      recursive = true;
    };
    ".config/rofi" = {
      source = ./dotfiles/rofi;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./dotfiles/nvim;
      recursive = true;
    };
    ".config/swww" = {
      source = ./dotfiles/swww;
      recursive = true;
    };
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that brought you the
  # settings you use in this configuration. This helps avoid breakage
  # when a new Home Manager release changes how things are configured.
  #
  # This value dates back to the first time you defined a stateful managed
  # service, and should normally not be changed.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
