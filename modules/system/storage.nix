{ config, pkgs, lib, ... }:
{
  # I/O Scheduler Optimization
  services.udev.extraRules = ''
    # Set scheduler for NVMe devices (none/none is optimal)
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="none"
    
    # Set scheduler for SATA SSDs (mq-deadline or none)
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"
    
    # Set scheduler for HDDs (bfq or mq-deadline)
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
  '';

  # Swappiness Tuning
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;  # Use 10 for desktop, 1 for servers with lots of RAM
    
    "vm.vfs_cache_pressure" = 50;  # Default is 100, lower = keep cache longer
    
    "vm.dirty_ratio" = 10;  # Default is 20
    "vm.dirty_background_ratio" = 5;  # Default is 10
  };

  # TRIM for SSDs
  services.fstrim = {
    enable = true;
    interval = "weekly";  # Options: "daily", "weekly", "monthly"
  };
}
