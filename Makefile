.PHONY: jupynvim
jupynvim:
	. ./scripts/jupynvim.sh

.PHONY: neovim_synch
neovim_synch:
	MODE="-neovim_synch" . ./scripts/confsync.sh


.PHONY: vim_synch
vim_synch:
	MODE="-vim_synch" . ./scripts/confsync.sh

