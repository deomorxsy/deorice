<div align="center">

## deorice
> dotfiles for \*nix setup ricing

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.5+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
</div>

PS: I recommend any readers to create your own configuration based on these dotfiles, it's not "production-ready" since part of it is built from scratch or by just customizing parts of the system.

PS 2: The following documentation in this README.md assumes the reader as a noob and tries to make them confortable with the idea of not being confortable, by searching for the main root cause of any future errors in the setup. As a general advice, even though there are scripts for automation in the repository, if you have time, try to make errors on purpose just to understand more of the system.


## Editors

### vim

The config is pretty straight-forward: just edit the ```~/.vimrc``` with vimscript/vimL syntax, place it in $HOME and next time you open vim it is already working. Search for the basics: the 7 vim modes, vimscript syntax, commands, etc. Read the errors and try to find the root cause. It's the best way to get out of future possible circles of the dependency hell.

### neovim

neovim adopts the ```~/.config/nvim/init.vim``` or ```~/.config/nvim/init.lua``` file as the default config file. It is also compatible with the vimrc; that explains the [source](https://github.com/deomorxsy/deorice/blob/main/.config/nvim/init.vim.old#L3).

This repository in specific migrates from the vimrc, used in vim, directly to the init.lua that uses the syntax of the [language lua] to program the editor. The runtime is the LuaJIT embedded in neovim and you can learn more in the [docs](https://neovim.io/doc/user/lua.html).

To use the base configuration, run the [playbooks (wip)](), execute the [scripts (wip)](https://github.com/deomorxsy/deorice/tree/main/scripts) or do it manually:

1. clone repository
```
git clone git@github.com:deomorxsy/deorice.git
cd ./deorice/
```
2. copy nvim to the $HOME config dotfile:
```
cp -r ./.config/nvim/ ~/.config/
```

3. install [packer](https://github.com/wbthomason/packer.nvim#quickstart) and open nvim.
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

4. Open nvim and enter in **Command-Line Mode**. Synchronize plugins in the configuration with packer and restart nvim session.
```
:PackerSync
```
5. for provider-related errors, specifically about python (ultisnips), setup using ```./.config/nvim/scripts/neovim-setup.sh``` or executing manually the following, which sets up the python provider $PATH based in the hack path that python uses with the virtualenv. [Based on the docs](https://neovim.io/doc/user/provider.html#python-virtualenv).
```python
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

# deactivate virtualenv
deactivate
```

main plugins used:
- [telescope](https://github.com/nvim-telescope/telescope.nvim) or [chadtree](https://github.com/ms-jpq/chadtree) for fuzzy search. The second is a whole [completion client](https://www.reddit.com/r/neovim/comments/p4m8vt/i_spent_1_year_of_my_life_on_making_a_fast_as/) spawning sqlite vms in memory and integrating with other external programs;
- [nvim-R](https://github.com/jalvesaq/Nvim-R) to run a R interpreter inside neovim (checkout the tmux integration)
- [vimtex](https://github.com/lervag/vimtex) for latex local editions;
- [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim) as a Language Server Protocols manager (literally acts as a package manager), which are external to neovim;
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to parse all the code in the editor, which builds an incremental tree that is useful for a bunch of tasks related to programming language constructs, like highlighting, indenting, folding of these constructs, text-object manipulation and [others](https://tree-sitter.github.io/tree-sitter/). Also fast af;
