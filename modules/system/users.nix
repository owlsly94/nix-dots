{ config, pkgs, ... }:
{
  users.users.owlsly = {
    isNormalUser = true;
    description = "Owlsly";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "libvirtd" 
      "video" 
      "kvm" 
      "spice" 
      "gamemode" 
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
