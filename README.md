
## deorice
> dotfiles for \*nix setup ricing

<div align="center">

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.5+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
</div>

PS: For any interested readers, try to create your own configuration based on these dotfiles.

PS2: Some of these are related with neovim running under tmux.

PS3: The following is not intended to be gatekeeping how to use any of these tools. Its just a merge between a personal opinionated configuration and a tutorial for posterity.

## Editors

### vim

The config is pretty straight-forward: just edit the ```~/.vimrc``` with vimscript/vimL syntax, place it in $HOME and next time you open vim it is already working. Search for the basics: the 7 vim modes, vimscript syntax, commands, etc. Read the errors and try to find the root cause. It's the best way to get out of future possible circles of the dependency hell.

### neovim

Neovim adopts the ```~/.config/nvim/init.vim``` or ```~/.config/nvim/init.lua``` file as the default config file. It is also compatible with the vimrc; that explains the [source](https://github.com/deomorxsy/deorice/blob/main/.config/nvim/init.vim.old#L3). It means these are the files neovim uses for configuration lookups every time the editor starts.

This repository in specific migrates from the vimrc, used in vim, directly to the init.lua that uses the syntax of the [language lua](https://www.lua.org/docs.html) to program the editor. The runtime is the [LuaJIT](https://luajit.org/) embedded in neovim and you can learn more in the [docs](https://neovim.io/doc/user/lua.html).

To handle LSP, DAP, linters and formatters you can use [mason-nvim](https://github.com/williamboman/mason.nvim). You can also integrate its functionality with [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim) into a not-bloated, fast [gattai-mecha](https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md) for completion.

To use the base configuration, run the [playbooks (wip)](), execute the [scripts (wip)](https://github.com/deomorxsy/deorice/tree/main/scripts) or do it manually:

1. Clone this repository:
```sh
git clone git@github.com:deomorxsy/deorice.git
cd ./deorice/
```

2. Copy nvim to the $HOME config dotfile:
```sh
cp -r ./.config/nvim/ ~/.config/
```

3. Clone [packer](https://github.com/wbthomason/packer.nvim#quickstart).
```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```


4. To avoid [provider-related](https://neovim.io/doc/user/provider.html) errors, specifically about python (ultisnips), you can use the script [neovim-setup.sh](./.config/nvim/scripts/neovim-setup.sh), ```./.config/nvim/scripts/neovim-setup.sh```, which sets up the python provider ```$PATH``` based in the hack path that python uses with the virtualenv, [adapted from the docs](https://neovim.io/doc/user/provider.html#python-virtualenv) ;)
```sh
cat > ./scripts/neovim-setup.sh << "EOF"
#!/usr/bin/sh
#
# packer plugin manager setup
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# setup python venv
python -m venv ~/.config/nvim/venv_nvim/neovim3

# source the venv activate binary
. ~/.config/nvim/venv_nvim/neovim3/bin/activate
python3 -m pip install pynvim==0.5.0

# returns the relative $PATH of the python binary installed on the virtualenv
pyvm=$(which python)

# checks if the placeholder exists on file
roco=$(awk 'FNR==14 && $3==p3hp_placeholder' "$HOME/.config/nvim/init.lua")

# using @ as sed delimiter since the bash variable expansion already uses
# the slash "/" character for the path
[ -n "$roco" ] && sed -e "s@p3hp_placeholder@$pyvm@g" "$HOME/.config/nvim/init.lua"

# deactivate virtualenv
deactivate
EOF

chmod +x ./scripts/neovim-setup.sh
. ./scripts/neovim-setup.sh
```

5. Set the python provider path
```sh
let g:python3_host_prog = "${HOME}/.config/nvim/venv_nvim/neovim3/bin/python"
```

6. Source the packer.lua file to finish installing packer. Then, also in command line, synchronize plugins in the configuration with packer.  I like the [headless flag](https://neovim.io/doc/user/starting.html#--headless) for this, otherwise just open the specific ```packer.lua``` file for sourcing, enter Terminal Mode and type ```:so```. Synchronize with ```PackerSync``` in any context.
```sh
nvim --headless -c 'so' -c 'PackerSync' "${HOME}/.config/nvim/lua/user/packer.lua"
```


Main plugins used in this vim/neovim rice, not ordered:
- [telescope](https://github.com/nvim-telescope/telescope.nvim) or [chadtree](https://github.com/ms-jpq/chadtree) for fuzzy search. The second is a whole [completion client](https://www.reddit.com/r/neovim/comments/p4m8vt/i_spent_1_year_of_my_life_on_making_a_fast_as/) spawning sqlite vms in memory and integrating with other external programs;
- [nvim-R](https://github.com/jalvesaq/Nvim-R) to run a R interpreter inside neovim (checkout the tmux integration);
- [vimtex](https://github.com/lervag/vimtex) for latex local editions;
- [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim) as a Language Server Protocols manager (literally acts as a package manager), which are external to neovim;
- [mason.nvim](https://github.com/williamboman/mason.nvim) as a package manager for LSP servers, DAP servers, linters, and formatters;
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to parse all the code in the editor. It builds an incremental parsing tree that is useful for a bunch of tasks related to programming language constructs, like highlighting, indenting, folding of these constructs, text-object manipulation and [others](https://tree-sitter.github.io/tree-sitter/). Also fast af;

