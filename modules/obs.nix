{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs                     # Za Wayland screen capture (ako zatreba)
      obs-backgroundremoval      # Za uklanjanje pozadine bez zelenog platna
      obs-pipewire-audio-capture # Najbolji način za zvuk na Pipewire-u
      obs-vaapi                  # AMD hardverska akceleracija
      obs-gstreamer              # Dodatni enkoderi
      obs-vkcapture              # Za direktan capture Vulkan igara (najbolje performanse)
    ];
  };
}
