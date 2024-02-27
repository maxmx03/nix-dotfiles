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
    extraHosts =
      builtins.readFile
      (pkgs.fetchFromGitHub {
          owner = "StevenBlack";
          repo = "hosts";
          rev = "3.14.52";
          sha256 = "1GnxuC08uOjoxiCiSVKmnetDHmWQGzMn99A5DtAA1Gw=";
        }
        + "/alternates/porn/hosts");
  };
}
