{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-vdpau-driver
      libvdpau-va-gl
      rocmPackages.clr.icd
      rocmPackages.rocminfo
      rocmPackages.rocm-runtime
      ocl-icd
      opencl-headers
    ];
  };

  powerManagement.cpuFreqGovernor = "schedutil";
  
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      HSA_OVERRIDE_GFX_VERSION = "10.3.2";
      OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
      HIP_VISIBLE_DEVICES = "0";
    };
  };
}
