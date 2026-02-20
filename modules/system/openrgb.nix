{ config, lib, pkgs, ... }:

{
  # Install the package
  environment.systemPackages = with pkgs; [
    openrgb
  ];

  # Enable i2c support
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  hardware.i2c.enable = true;

  # Udev rules for RGB controllers
  services.udev.extraRules = ''
    # Allow access to RGB controllers
    SUBSYSTEM=="usb", ATTR{idVendor}=="1e71", MODE="0666"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", MODE="0666"
  '';

  # Add user to i2c group
  users.users.owlsly.extraGroups = [ "i2c" ];

  #Run OpenRGB server on boot
  systemd.services.openrgb = {
    description = "OpenRGB Server";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.openrgb}/bin/openrgb --server --server-port 6742";
      Restart = "on-failure";
      User = "root";
    };
  };
}
