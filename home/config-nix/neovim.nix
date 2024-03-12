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
    nodePackages_latest.bash-language-server
    emmet-ls
    nodePackages_latest.vim-language-server
    marksman
    docker-compose-language-service
    nodePackages_latest.intelephense
    nodePackages."@astrojs/language-server"
    nodePackages."dockerfile-language-server-nodejs"
    nodePackages."@tailwindcss/language-server"
    markdownlint-cli
    # formatters
    black
    prettierd
    alejandra
  ];

  home.file = let
    homeFiles = path: {
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/config/nvim";
      ".local/share/fonts".source = "${path}/fonts";
    };
  in
    homeFiles
    ../config;
}
