#!/usr/bin/bash

#neovim utils

# packer plugin manager setup
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# setup python3 provider
python -m venv ~/.config/nvim/venv_nvim/neovim3

source ~/.config/nvim/venv_nvim/neovim3/bin/activate
python3 -m pip install neovim

roco = $(awk 'FNR==14 && $3==p3hp_placeholder' ~/.config/nvim/init.lua)

[ -n $result ] && sed -i 's/p3hp_placeholder/"$(which python)"/' ~/.config/nvim/init.lua

# outputs the local binary from the virtualenv
