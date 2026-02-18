{ config, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "amdgpu" ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
  };
}
