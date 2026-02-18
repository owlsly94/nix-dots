{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system-services.nix
    ./modules/system-packages.nix
  ];

  ############################################
  ##### BOOTLOADER & SYSTEM CONFIGURATION ####
  ############################################
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;  # Only keep last 10 generations in boot menu
  };
  boot.loader.efi.canTouchEfiVariables = true;

  ##################################
  ### NETWORKING & LOCALIZATION ####
  ##################################
  networking.hostName = "OwlslyBox";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  ####################################
  ### HARDWARE & GPU CONFIGURATION ###
  ####################################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Video acceleration
      libva
      libva-vdpau-driver
      libvdpau-va-gl
      # ROCm/OpenCL
      rocmPackages.clr.icd
      rocmPackages.rocminfo
      rocmPackages.rocm-runtime
      ocl-icd
      opencl-headers
    ];
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  powerManagement.cpuFreqGovernor = "schedutil";
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "10.3.2";  # Navi23 (RX 6600)
    OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
    HIP_VISIBLE_DEVICES = "0";
  };

  ##################################
  ### DISPLAY MANAGER & WAYLAND ####
  ##################################
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #####################
  ##### USER SETUP ####
  #####################
  users.users.owlsly = {
    isNormalUser = true;
    description = "Owlsly";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "kvm" "spice" "gamemode" ];
    shell = pkgs.zsh;
  };

  ####################
  ### GAMING SETUP ###
  ####################
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
      cpu = {
        governor = "performance";
        park_cores = false;
        pin_cores = false;
      };
      custom = {
        start = "${pkgs.dunst}/bin/dunstify -a 'Gamemode' 'Optimizations activated' -u low";
        end = "${pkgs.dunst}/bin/dunstify -a 'Gamemode' 'Optimizations deactivated' -u low";
      };
    };
  };

  programs.zsh.enable = true;

  #########################
  ### NIX CONFIGURATION ###
  #########################
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; #Do NOT change
}
