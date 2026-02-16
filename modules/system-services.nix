{ config, pkgs, ... }:

{
  ##########################
  ### FILE MANAGER SETUP ###
  ##########################
  services.gvfs.enable = true;    # Virtual filesystem (trash, remote mounts, etc.)
  services.tumbler.enable = true; # Thumbnail generation for Thunar
  services.udisks2.enable = true; # Disk management daemon

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin # Right-click archive creation/extraction
      thunar-volman         # Removable device management
    ];
  };

  ############################
  ### VIRTUALIZATION SETUP ###
  ############################
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;                    # TPM emulation for Windows 11 VMs
        vhostUserPackages = [ pkgs.virtiofsd ]; # Virtio-fs daemon for host/guest sharing
      };
    };
    spiceUSBRedirection.enable = true; # USB passthrough to VMs via SPICE
  };

  programs.virt-manager.enable = true;   # GUI for managing VMs
  services.spice-vdagentd.enable = true; # SPICE agent (clipboard sync, auto-resize)

  ####################
  ### AUDIO SETUP ####
  ####################
  security.rtkit.enable = true; # Realtime scheduling for audio threads
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Required for 32-bit apps (e.g. Wine/Steam)
    pulse.enable = true;      # PulseAudio compatibility layer
  };

  ##############################
  ### AMDGPU CONTROL DAEMON ####
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
}
