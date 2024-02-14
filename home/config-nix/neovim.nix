{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    neovim
    lazygit
    ripgrep
    gcc
    go
    # lsp-servers
    lua-language-server
    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    typescript
    nodePackages.pyright
    nixd
    yaml-language-server
    gopls
    # formatters
    black
    prettierd
    alejandra
  ];

  home.file = let
    homeFiles = path: {
      ".config/nvim".source = "${path}/nvim";
      ".local/share/fonts".source = "${path}/fonts";
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
}
