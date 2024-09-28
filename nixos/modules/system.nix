{ pkgs, config, ... }:
let
  username = "n";
in {

  ### users ####################################################################

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
  };

  nix.settings.trusted-users = [username];


  ### misc #####################################################################

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only
  # boot.loader.grub.useOSProber = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow unfree
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  ### virtualization ###########################################################
  # note the (necessary) incorrect spelling

  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };


  ### environment ##############################################################

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {

    systemPackages = with pkgs; [
      bitwarden-cli
      cbonsai
      clang
      curl
      fastfetch
      feh
      gawk
      gcc-unwrapped
      git
      htop
      i3lock
      inetutils
      jq
      libstdcxx5
      lshw
      maim
      nettools
      nix-prefetch-git
      pavucontrol
      pciutils
      pcmanfm
      ripgrep
      sqlite
      sshfs
      stdenv.cc.cc.lib  # make
      unzip
      wget
      xclip
      xorg.xauth
      xorg.xinit
      zip
    ];

  };

  ### services #################################################################

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 5900 24800 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.wireless = {
    userControlled.enable = true;
    secretsFile = "/home/${username}/.config/wifi/wireless.env";
    networks = {
      "Waffle House".pskRaw = "ext:PSK_HOME";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # xserver + i3
  services = {

    displayManager.defaultSession = "none+i3";
    logind.lidSwitch = "ignore";

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      desktopManager = {
        xterm.enable = false;
        session = [{
          name = "i3";
          start = ''${pkgs.i3}/bin/i3'';
        }];
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };

  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  ### vpn ######################################################################

  # load config
  # openvpn3 config-import --config /etc/openvpn/profile-139.ovpn --name cl --persistent
  programs.openvpn3.enable = true;


  ### vnc ######################################################################

  systemd = {
    services.x11vnc = {
      description = "x11vnc";
      after = [ "network.target" "display-manager.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.x11vnc}/bin/x11vnc -forever -display :0 -auth /home/n/.Xauthority -noxdamage";
        ExecStop = "${pkgs.killall}/bin/killall x11vnc";
        Type = "simple";
        Restart = "on-failure";
        User = "n";
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=5s
    '';
  };


  ### fonts ####################################################################

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [
      "Mononoki"
      "RobotoMono"
      "UbuntuMono"
    ]; }) ];

}
