{ config, pkgs, ... }:
{
  networking = {
    hostName = "OwlslyBox";
    networkmanager.enable = true;
  };
  
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
}
