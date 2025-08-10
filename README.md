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

- Connect GitHub via SSH

  You have two options for managing your SSH keys:

  ### Option 1: Using 1Password as your SSH Agent (Recommended)

  This is the recommended and more secure way to manage your SSH keys.

  1.  **Ensure 1Password's SSH Agent is enabled:**
      *   Open 1Password application.
      *   Go to Settings/Preferences -> Developer (or SSH) and ensure the SSH agent is turned on.

  2.  **Configure your SSH client:**
      *   Edit or create the `~/.ssh/config` file.
      *   Add the following lines to use the 1Password SSH agent:

      ```
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/Library/Application Support/1Password/Data/ssh/agent.sock"
      ```

      *   After saving, restart your terminal or run `ssh-add -l` to verify that 1Password keys are listed.

  3.  **Add your SSH key to GitHub via 1Password:**
      *   Generate a new SSH key within 1Password or import an existing one.
      *   Use `gh auth login` and `gh ssh-key add` as usual. 1Password will handle the key signing.

  

  - After finishing the instructions, execute this command to update your git remote:

  ```bash
  cd ~/repo/github.com/diohabara/dotfiles
  git remote set-url origin git@github.com:diohabara/dotfiles.git
  ```
  ```

### 1Password CLI Configuration (Optional)

For managing 1Password CLI (`op` command) settings, you can create a `~/.op/config` file.

**IMPORTANT SECURITY NOTE:** Do NOT include sensitive information like session tokens or API keys directly in this file if you plan to make your dotfiles public. Use environment variables or 1Password's built-in secure storage for such sensitive data.

Here's an example of a `~/.op/config` file that you can manage with your dotfiles:

```
# ~/.op/config
# This file is for 1Password CLI configuration.
# DO NOT include sensitive information like session tokens directly in a public dotfiles repository.

# Example: Specify a default account shorthand
# op_account_shorthand = "my_personal_account"

# Example: Specify a default vault
# op_vault = "Personal"

# Example: Path to the 1Password CLI binary (if not in PATH)
# op_path = "/Applications/1Password.app/Contents/MacOS/op"
```

You can manage this file by creating a symlink from your dotfiles repository to `~/.op/config`.

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
