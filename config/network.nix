{pkgs, ...}: {
  networking = {
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.   };
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
    hostName = "milianor";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      appendNameservers = ["1.1.1.3" "1.0.0.3"];
    };
    stevenBlackHosts = {
      blockFakenews = false;
      blockGambling = false;
      blockPorn = true;
      blockSocial = false;
    };
  };
}
