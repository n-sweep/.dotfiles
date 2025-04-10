# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {

    "/" = {
      device = "/dev/disk/by-uuid/23106bdd-e8f2-46d9-81af-7c3cbe0e1492";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/AF8A-6FE0";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    "/mnt/bigdrive" = {
      device = "/dev/disk/by-uuid/0afdf305-ab80-4607-b1c2-8d1d9763a430";
      fsType = "ext4";
    };

    "/mnt/music" = {
      device = "192.168.0.112:/mnt/pool-1/media/music/library";
      fsType = "nfs";
    };

  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8472230e-d0b9-44e4-bc9c-db7ed1979e71"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp41s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp43s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;

      prime = {
        sync.enable = true;

        # lspci | rg VGA
        nvidiaBusId = "PCI:01:00:0";
        intelBusId = "PCI:00:02:0";

      };

    };

    system76.enableAll = true;

  };
}
