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
    grim
    slurp
    gnome.eog
  ];

  home.file = let
    homeFiles = outOfStore: configPath: {
      ".config/hypr".source = outOfStore "${configPath}/hypr";
      ".config/waybar".source = outOfStore "${configPath}/waybar";
      ".config/rofi".source = outOfStore "${configPath}/rofi";
      ".config/wlogout".source = outOfStore "${configPath}/wlogout";
      ".config/foot".source = outOfStore "${configPath}/foot";
      ".wallpapers".source = outOfStore "${config.home.homeDirectory}/dotfiles/wallpapers";
    };
  in
    homeFiles
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/home/config";

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

  programs.bash.profileExtra = ''
    export NIXPKGS_ALLOW_UNFREE=1
    export GTK_THEME="WhiteSur-Dark"
    export XDG_SESSION_DESKTOP="Hyprland"
    export XDG_SESSION_TYPE="wayland"
    export XDG_CURRENT_DESKTOP="Hyprland"

    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
      exec Hyprland
    fi
  '';
}
