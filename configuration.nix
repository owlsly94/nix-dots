{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "OwlslyBox";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
    libva
    libva-vdpau-driver
    libvdpau-va-gl
    rocmPackages.clr.icd
    ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.sessionVariables = { 
  LIBVA_DRIVER_NAME = "radeonsi"; 
  NIXOS_OZONE_WL = "1"; 
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "owlsly";
    };
  };
  programs.hyprland.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.owlsly = {
    isNormalUser = true;
    description = "Owlsly";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    lact
    virt-manager
    wlr-randr
    pavucontrol
    mangohud
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  virtualisation.libvirtd.enable = true;
  
  programs.zsh.enable = true;

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
