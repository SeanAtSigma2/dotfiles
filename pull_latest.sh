#! /usr/bin/env bash

set -e

cp ~/.tmux.conf ./.tmux.conf
cp ~/.zshrc ./.zshrc
cp -R ~/.config/nvim/lua ./nvim/
cp ~/.config/nvim/.neoconf.json ./nvim/.neoconf.json
cp ~/.config/nvim/stylua.toml ./nvim/stylua.toml
cp ~/.config/nvim/init.lua ./nvim/init.lua
cp ~/.config/nvim/lazy-lock.json ./nvim/lazy-lock.json
rm -rf ./nvim/.git
