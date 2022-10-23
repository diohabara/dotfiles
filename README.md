# dotfiles

[![GitHub Actions](https://github.com/diohabara/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/diohabara/dotfiles/actions/workflows/ci.yml)

For macOS and Linux(Ubuntu).

## setup

### macOS

- Before execute this command, sign in to App Store.
- You may need to type `sudo xcodebuild -license accept`

```bash
xcode-select --install
sudo softwareupdate --install-rosetta
```

- set capslock to be ctrl
- enable three-finger drag
- disable Spotlight in "Keyboard shortcuts" in "System Preferences"
- make "Key Repeat" and "Delay Until Repeat" fastest and shortest in "System Preferences" respectively
- disable Spotlight in "Keyboard shortcuts" in "System Preferences"
- change Alfred's shortcut `command + space`
- change "Define a word"'s shortcut `d`
- make "Key Repeat" and "Delay Until Repeat" fastest and shortest in "System Preferences" respectively
- set up
  - ShiftIt
    - change keyboard shortcuts
    - disable menu bar icon
  - Google Japanese Input
    - change "Keymap" to "ATOK" in "General"
    - make conversions in "Advanced" halfwidth
- manually install [Tailscale](https://apps.apple.com/ca/app/tailscale/id1475387142)
- enable `sudo` by touchID

  - open `/etc/pam.d/sudo`
  - add this line below `auth sufficient pam_smartcard.so`

  ```txt
  auth sufficient pam_tid.so
  ```

  - edit like below

  ```txt
  # sudo: auth account password session
  auth       sufficient     pam_smartcard.so
  auth       sufficient     pam_tid.so
  auth       required       pam_opendirectory.so
  account    required       pam_permit.so
  password   required       pam_deny.so
  session    required       pam_permit.so
  ```

### Ubuntu

```sh
sudo apt update && sudo apt upgrade -y && sudo apt install -y curl
```

- manually install
  - [VSCode](https://code.visualstudio.com/docs/setup/linux)
  - [Slack](https://slack.com/intl/ja-jp/downloads/linux)
  - [Docker](https://docs.docker.com/engine/install/ubuntu/)
  - [Spotify](https://www.spotify.com/us/download/linux/)
  - [Vivado](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html)
    - install the latest version of Vivado
      - download 2020.3 version
      - `chmod +x` the installer
      - execute with `sudo`
        - do not check _installation options_
      - `sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5`
      - `source settings64.sh` in `/tools/Xilinx/`
      - Then, you can start `vivado`
    - (refer to [this link](https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/))

### Common

```sh
bash -c "$(curl -fsSL raw.github.com/diohabara/dotfiles/master/bin/setup.sh)"
```

- change your shell: `chsh -s $(which zsh)`
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
- After the update of macOS, append this code to `/etc/zhsrc` according to [this commenct](https://github.com/NixOS/nix/issues/3616)

  ```bash
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  ```
