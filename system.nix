# System-wide configuration for NixOS
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixnix";
  networking.networkmanager.enable = true;

  programs.hyprland.enable = true;

  # Unfree
  nixpkgs.config.allowUnfree = true;

  # Time zone
  time.timeZone = "Asia/Tokyo";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # X11 keymap (kept for X11 compatibility, note Hyprland uses 'us' layout)
  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  # User account
  users.users.justin = {
    isNormalUser = true;
    description = "Justin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # System packages (minimal, system-wide only)
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland # System-wide portal functionality
    fcitx5-mozc                # Input method (system-wide)
    fcitx5-configtool          # Input method configuration
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts._0xproto
      nerd-fonts.hack
    ];
  };

  # Enable PipeWire as a service
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  system.stateVersion = "24.11";

  security.polkit.enable = true;

  nix.settings.experimental-features = [
    "nix-command" "flakes"
  ];
}
