{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./home/config-nix/hyprland.nix
    ./home/config-nix/neovim.nix
    ./home/config-nix/vim.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "milianor";
  home.homeDirectory = "/home/milianor";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    foot
    neofetch
    eza
    rustc
    cargo
    starship
    git
    yarn
    fd
    fzf
    bat
    python3
    nodejs_21
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    nodePackages."@angular/cli"
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = let
    homeFiles = path: {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
      ".config/neofetch".source = "${path}/neofetch";
      ".tmux.conf".source = "${path}/.tmux.conf";
    };
  in
    homeFiles
    ./home/config;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/milianor/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    CARGO_TARGET_DIR = "/tmp/cargo-installlwmeeA";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        ls = "eza --icons";
        ll = "eza --long --icons -a";
        g = "lazygit";
      };
      initExtra = ''
        source "$HOME/dotfiles/scripts/notes.sh"
        source "$HOME/dotfiles/scripts/z.sh"
        source <(ng completion script)

        eval "$(starship init bash)"

        if [ -z "$TMUX" ]; then
            neofetch
        fi

        if [ -z "$TMUX" ] && [ "$TERM" = "foot" ]; then
            export TERM="xterm-256color"
        fi
      '';
      bashrcExtra = ''
        export FZF_DEFAULT_COMMAND='fd --type f -H -E .git -E .vscode --strip-cwd-prefix'
        export FZF_DEFAULT_OPTS="
          --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
          --color=fg:#908caa,bg:#191724,hl:#ebbcba
          --color=border:#403d52,header:#31748f,gutter:#191724
          --color=spinner:#f6c177,info:#9ccfd8
          --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

        export PATH="$PATH:$HOME/.schemecraft/bin"
        export PATH="$PATH:$HOME/.cargo/bin"
      '';
    };
    home-manager.enable = true;
  };
}
