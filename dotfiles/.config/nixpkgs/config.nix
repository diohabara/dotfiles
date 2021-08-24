let pkgs = import <nixpkgs> { };
in {
  allowBroken = true;
  allowUnfree = true;
  allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          # node packages
          nodePackages.bash-language-server
          nodePackages.js-beautify
          nodePackages.npm
          nodePackages.prettier
          nodePackages.pyright
          nodePackages.stylelint
          nodejs

          # Python packages
          pipenv
          python38Packages.python-language-server
          python39
          python39Packages.isort
          python39Packages.nose
          python39Packages.pip
          python39Packages.pyflakes
          python39Packages.pytest
          wakatime

          # Rust packages
          alacritty
          bat
          bottom
          delta
          dust
          exa
          fd
          hyperfine
          mdbook
          procs
          ripgrep
          rust-analyzer
          sd
          tectonic
          tokei

          # Go packages
          fzf
          ghq
          go
          gocode
          golangci-lint
          gomodifytags
          gore
          gotests

          # Haskell packages
          ghc
          haskellPackages.ghcup
          pandoc
          stack

          # Git tools
          gh
          git
          git-lfs

          # others
          aspell
          bazel
          bazel-buildtools
          bison
          black
          broot
          ccls
          cmake
          coreutils
          curl
          editorconfig-checker
          editorconfig-core-c
          expat
          ffmpeg
          flock
          gawk
          gdb
          gibo
          glslang
          gmp
          gnused
          gradle
          gzip
          isl
          jq
          libmpc
          libtelnet
          mpfr
          neofetch
          neovim
          ninja
          nixfmt
          opam
          openssl
          pkg-config
          poetry
          readline
          rlwrap
          roswell
          rsync
          rufo
          sbcl
          shellcheck
          shfmt
          starship
          tcl
          tldr
          tmux
          typora
          unzip
          wget
          xz
          yarn
          youtube-dl
          zlib
          zoxide
        ];
      };
    };
}
