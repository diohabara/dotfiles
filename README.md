# dotfiles

[![GitHub Actions](https://github.com/diohabara/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/diohabara/dotfiles/actions/workflows/ci.yml)

For macOS only.

## setup

### Quick setup

```sh
curl -fsSL https://raw.githubusercontent.com/diohabara/dotfiles/master/script/install | sh
```

### Manual setup

```sh
git clone https://github.com/diohabara/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/setup.sh
```

### Dry run

実際に変更を加えずに、何が実行されるかを確認できます:

```sh
# Quick setup の場合
curl -fsSL https://raw.githubusercontent.com/diohabara/dotfiles/master/script/install | sh -s -- --dry-run

# Manual setup の場合
./script/setup.sh --dry-run
# または
./script/setup.sh -n
```

### GitHub Setup

Run `gh auth login` and follow the prompts. If needed, update the dotfiles remote:

```bash
cd ~/repo/github.com/diohabara/dotfiles
git remote set-url origin git@github.com:diohabara/dotfiles.git
```

`./script/setup.sh` also sets GitHub CLI's git protocol to SSH, so `gh repo clone` uses `git@github.com:` style URLs by default:

```bash
gh repo clone diohabara/cs101
```

