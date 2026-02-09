{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Mreža i Regionalna podešavanja
  networking.hostName = "OwlslyBox";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  # Grafika i Window Manager
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  programs.hyprland.enable = true;

  # Tastatura
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Zvuk (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Korisnik (Shell je prebačen na ZSH)
  users.users.owlsly = {
    isNormalUser = true;
    description = "Owlsly";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" ];
    shell = pkgs.zsh;
  };

  # Sistemski programi (Esencijalne stvari i drajveri)
  environment.systemPackages = with pkgs; [
    wget
    git
    lact # AMD GPU alat
    virt-manager
    wlr-randr
  ];

  # Gaming i Virtualizacija (Mora sistemski)
  programs.steam.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.zsh.enable = true;

  # Nix Podešavanja
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
