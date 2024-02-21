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
    nodePackages.vim-language-server
    nodePackages_latest.bash-language-server
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
