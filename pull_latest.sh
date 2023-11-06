#! /usr/bin/env bash

set -e

# TMUX
cp ~/.tmux.conf ./.tmux.conf
cp ~/.config/tmuxinator/* ./tmuxinator/

# ZSH
cp ~/.zshrc ./.zshrc

# Neovim
cp -R ~/.config/nvim/lua ./nvim/
cp ~/.config/nvim/.neoconf.json ./nvim/.neoconf.json
cp ~/.config/nvim/stylua.toml ./nvim/stylua.toml
cp ~/.config/nvim/init.lua ./nvim/init.lua
cp ~/.config/nvim/lazy-lock.json ./nvim/lazy-lock.json
rm -rf ./nvim/.git

# Mutt
cp ~/.mutt/muttrc ./.mutt/muttrc
cp ~/.mutt/mailcap ./.mutt/mailcap
