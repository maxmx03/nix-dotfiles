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
}
