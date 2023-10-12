#!/usr/bin/bash

#neovim utils

# packer plugin manager setup
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# setup python3 provider
python -m venv ~/.config/nvim/venv_nvim/neovim3

source ~/.config/nvim/venv_nvim/neovim3/bin/activate
python3 -m pip install neovim

# returns the relative $PATH of the python binary installed on the virtualenv
pyvm=$(which python)

# checks if the placeholder exists on file
roco=$(awk 'FNR==14 && $3==p3hp_placeholder' ~/.config/nvim/init.lua)

# using @ as sed delimiter since the bash variable expansion already uses
# the slash "/" character for the path
[ -n $roco ] && sed -e "s@p3hp_placeholder@$pyvm@g" ~/.config/nvim/init.lua

deactivate
