.PHONY: jupynvim
jupynvim:
	. ./scripts/jupynvim.sh

.PHONY: sync-nvim
sync-nvim:
	MODE="-synch" . ./scripts/confsync.sh

