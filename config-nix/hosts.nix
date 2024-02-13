{pkgs, ...}: {
  networking.extraHosts =
    builtins.readFile
    (pkgs.fetchFromGitHub {
        owner = "StevenBlack";
        repo = "hosts";
        rev = "3.14.52";
        sha256 = "1GnxuC08uOjoxiCiSVKmnetDHmWQGzMn99A5DtAA1Gw=";
      }
      + "/alternates/porn/hosts");
}
