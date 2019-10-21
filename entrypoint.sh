#!/usr/bin/env bash
rm .zshrc
yadm clone https://github.com/akngs/denv-dotfiles
cp ~/.config/yadm.git.config ~/.yadm/repo.git/config
zsh
