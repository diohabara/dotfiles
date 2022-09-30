{ config, pkgs, ... }:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in
{
  # config
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  home.stateVersion = "18.09";

  home = {
    username = "${name}";
    packages = with pkgs; [
      # fonts
      # Docs: https://github.com/ryanoasis/nerd-fonts/blob/master/bin/scripts/lib/fonts.json
      (nerdfonts.override {
        fonts = [
          "AnonymousPro"
          "FiraCode"
          "JetBrainsMono"
          "Noto"
          "Ubuntu"
          "UbuntuMono"
        ];
      })

      # node packages
      nodePackages.bash-language-server
      nodePackages.prettier

      # Python packages
      python310Packages.black
      python310Packages.isort
      python310Packages.pip
      python310Packages.poetry
      python310Packages.python-lsp-server
      python310Packages.yamllint
      wakatime

      # Rust packages
      bat
      bottom
      delta
      exa
      fd
      hyperfine
      ripgrep
      rust-analyzer
      starship
      tectonic

      # Go packages
      fzf
      ghq
      shfmt

      # Git tools
      act
      gh
      git
      git-lfs

      # editor
      neovim

      # others
      #binutils
      cachix
      ccls
      clang-tools
      cmake
      coreutils
      curl
      docker
      docker-compose
      editorconfig-checker
      editorconfig-core-c
      ffmpeg
      findutils
      fontconfig
      gawk
      gdb
      gmp
      gnused
      gzip
      imagemagick
      isl
      libmpc
      libtelnet
      llvm
      most
      mpfr
      neofetch
      nixfmt
      nixpkgs-fmt
      openssl
      pkg-config
      readline
      rlwrap
      rnix-lsp
      shellcheck
      texlive.combined.scheme-minimal
      tldr
      tmux
      unzip
      wget
      xz
      yt-dlp
      zlib
    ];
  };

  # programs.bat = {
  #   enable = true;
  #   config = {
  #     theme = "GitHub";
  #     italic text = "always";
  #   };
  # };

  # programs.git = {
  #   enable = true;
  #   userName = "diohabara";
  #   userEmail = "diohabara@gmail.com";
  #   extraConfig = {
  #     core = {
  #       editor = "nvim";
  #       quotepath = "false";
  #       excludefile = "~/.git/ignore";
  #     };
  #     color = {
  #       ui = "auto";
  #     };
  #     push = {
  #       default = "simple";
  #     };
  #     pull = {
  #       ff = "only";
  #     };
  #     init = {
  #       templatedir = "~/.config/git/templates";
  #       defaultBranch = "main";
  #     };
  #   };
  #   ignores = [
  #     ".DS_Store"
  #   ];
  #   delta = {
  #     navigate = true;
  #     line numbers = true;
  #     syntax theme = "GitHub";
  #   };
  # };
}

