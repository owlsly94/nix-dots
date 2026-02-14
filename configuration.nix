{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ############################################
  ### BOOTLOADER & SYSTEM CONFIGURATION ###
  ############################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##################################
  ### NETWORKING & LOCALIZATION ###
  ##################################
  networking.hostName = "OwlslyBox";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  ###################################
  ### HARDWARE & GPU CONFIGURATION ###
  ###################################
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

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "cpufreq_performance" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    NIXOS_OZONE_WL = "1";
  };

  ##############################
  ### AMDGPU CONTROL DAEMON ###
  ##############################
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
      Restart = "always";
    };
  };

  ##################################
  ### DISPLAY MANAGER & WAYLAND ###
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

  #######################
  ### AUDIO SETUP ###
  #######################
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #####################
  ### USER SETUP ###
  #####################
  users.users.owlsly = {
    isNormalUser = true;
    description = "Owlsly";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "kvm" "spice" "gamemode" ];
    shell = pkgs.zsh;
  };

  ############################
  ### SYSTEM PACKAGES ###
  ############################
  environment.systemPackages = with pkgs; [
    # Package managers & versioning
    wget
    git

    # System utilities
    pavucontrol      # Audio volume control
    mangohud         # Performance overlay
    unzip            # Archive extraction
    udiskie          # Auto-mount USB devices
    htop             # System monitor
    tree             # Directory tree display

    # Development & graphics
    glfw              # OpenGL window library
    ffmpegthumbnailer # Thumbnail generation for videos
  ];

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
      custom = {
        start = "${pkgs.dunst}/bin/dunstify -a 'Gamemode' 'Optimizations activated' -u low";
        end = "${pkgs.dunst}/bin/dunstify -a 'Gamemode' 'Optimizations deactivated' -u low";
      };
    };
  };

  #########################
  ### FILE MANAGER SETUP ###
  #########################
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  ###########################
  ### VIRTUALIZATION SETUP ###
  ###########################
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true;

  programs.zsh.enable = true;

  #######################
  ### NIX CONFIGURATION ###
  #######################
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
