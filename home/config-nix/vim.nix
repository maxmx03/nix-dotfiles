{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vim
    python311Packages.pynvim
  ];

  home.file = {
    ".vim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/config/vim";
    "vim-plug".source = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "vim-plug";
      rev = "0.11.0";
      sha256 = "6HVwA69fXZ7KkZFbSr+hOZ2epkQoT1BBN6HYMGxTzy0=";
    };
  };
}
