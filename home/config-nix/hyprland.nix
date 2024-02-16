{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    foot
    wl-clipboard
    cliphist
    dunst
    mako
    jq
    xdg-utils
    unzip
    unrar
    whitesur-gtk-theme
    whitesur-icon-theme
    waybar
    wlogout
    swww
    rofi-wayland
    networkmanagerapplet
    gnome.nautilus
    pavucontrol
    pamixer
    cmus
    mpv
  ];

  home.file = let
    homeFiles = path: {
      ".config/hypr".source = "${path}/hypr";
      ".config/waybar".source = "${path}/waybar";
      ".config/rofi".source = "${path}/rofi";
      ".config/wlogout".source = "${path}/wlogout";
      ".config/foot".source = "${path}/foot";
      ".profile".source = "${path}/.profile";
      ".wallpapers".source = ../../wallpapers;
    };
  in
    homeFiles
    ../config;

  home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      x11.enable = true;
      name = name;
      size = 24;
      package = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = url;
          hash = hash;
        }} $out/share/icons/${name}
      '';
    };
  in
    getFrom
    "https://github.com/ful1e5/apple_cursor/releases/download/v2.0.0/macOS-BigSur.tar.gz"
    "sha256-VZWFf1AHum2xDJPMZrBmcyVrrmYGKwCdXOPATw7myOA="
    "macOS-BigSur";

  gtk = {
    enable = true;
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-Dark";
    };

    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
  };

  xdg = {
    enable = true;
  };
}
