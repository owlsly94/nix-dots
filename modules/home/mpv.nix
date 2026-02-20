{ pkgs, lib, ... }: 

{
  programs.mpv = {
    enable = true;
    
    config = lib.mkForce {
      vo = "gpu";
      gpu-api = "vulkan";
      vulkan-async-compute = "yes";

      hwdec = "vaapi";
      hwdec-codecs = "h264,hevc,vp9,av1";

      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";

      dither = "fruit";
      temporal-dither = "yes";
      dither-depth = "auto";

      sub-font = "Noto Sans";
      sub-font-size = 42;
      sub-border-size = 3;
      sub-shadow-offset = 2;

      osc = "yes";
      osd-bar = "yes";
      osd-font-size = 24;
      keep-open = "yes";
    };

    profiles = lib.mkForce {
      movies = {
        profile-desc = "For movies";
        interpolation = "yes";
        tscale = "oversample";
        deband = "yes";
        deband-iterations = 4;
        deband-threshold = 48;
        deband-range = 16;
        deband-grain = 6;
        cache = "yes";
        cache-secs = 60;
        demuxer-max-bytes = "500MiB";
      };
      youtube = {
        profile-desc = "YouTube live";
        interpolation = "no";
        deband = "yes";
        deband-iterations = 2;
        deband-threshold = 32;
        deband-grain = 4;
        cache = "yes";
        cache-secs = 30;
        demuxer-max-bytes = "1GiB";
        demuxer-readahead-secs = 30;
        hls-bitrate = "max";
      };
    };
  };
}
