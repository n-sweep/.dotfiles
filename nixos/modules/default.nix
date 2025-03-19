# the config in this file will be applied to every machine

{ pkgs, ... }:
let
  uname = "n";
  home_dir = "/home/${uname}";
in {

  ### users ####################################################################

  users.users.${uname} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
  };

  nix.settings.trusted-users = [uname];


  ### misc #####################################################################

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
      clang
      curl
      docker-compose
      git
      stdenv.cc.cc.lib  # make
      wget
    ];

    variables = {
      XDG_DATA_HOME = "${home_dir}/.local/share";
    };

  };

  ### services #################################################################

  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22      # ssh
    5900    # obs (?)
    5619    # pomo (?)
    8888    # jupyter notebook
    24800   # ????
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  ### vpn ######################################################################

  # load config
  # openvpn3 config-import --config /etc/openvpn/profile-139.ovpn --name cl --persistent
  # programs.openvpn3.enable = true;

  ### fonts ####################################################################

  fonts.packages = with pkgs; [
    roboto
    nerd-fonts.mononoki
    nerd-fonts.roboto-mono
    nerd-fonts.ubuntu-mono
  ];

}
