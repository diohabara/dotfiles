# dotfiles

[![GitHub Actions](https://github.com/diohabara/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/diohabara/dotfiles/actions/workflows/ci.yml)

For macOS and Linux(Ubuntu).

## setup

### Quick setup

```sh
curl -fsSL https://raw.githubusercontent.com/diohabara/dotfiles/master/script/setup.sh | bash
```

### Manual setup

```sh
git clone https://github.com/diohabara/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/setup.sh
```

### macOS

- change Raycast's shortcut `command + space`
  - change "Define a word"'s shortcut `d`
- set up
  - Google Japanese Input
    - change "Keymap" to "ATOK" in "General"
    - make conversions in "Advanced" halfwidth

- connect GitHub via SSH

  - First follow this link <https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>.

  ```bash
  ssh-keygen -t ed25519 -C "your_email@example.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  gh auth login
  gh ssh-key add ~/.ssh/id_ed25519.pub
  ```

  - After finishing the instructions, execute this command.

  ```bash
  cd ~/repo/github.com/diohabara/dotfiles
  git remote set-url origin git@github.com:diohabara/dotfiles.git
  ```

## Troubleshooting

- If you having difficulty Doom Emacs font rendering, please refer to [this issue](https://github.com/hlissner/doom-emacs/issues/116).
- After the update of macOS, append this code to `/etc/zshrc` according to [this comment](https://github.com/NixOS/nix/issues/3616)

  ```bash
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  ```
