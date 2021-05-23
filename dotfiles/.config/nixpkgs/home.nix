# Ref: https://github.com/JonathanReeve/dotfiles/blob/minimal/dotfiles/home.nix
{pkgs, ...}:

let
  name = "diohabara";
  email = "diohabara@gmail.com";
  githubUsername = "diohabara";
in
{
  programs = {
    home-manager = {
      enable = true;
    };
  };

  home = {
    username = "${name}";
    packages = with pkgs; [
      nixfmt
      exa
      bat
      gcc
      gnumake
      wget
      pandoc                 
      tectonic               
      git                    
      stack
      ghc
      fzf                    
      fd                     
    ];
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ]);
  };
}
