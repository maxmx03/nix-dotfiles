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
}
