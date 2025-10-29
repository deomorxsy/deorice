#!/bin/sh

podman run --rm -it \
    -v ./wms/xmonad/:/app/:ro \
    --entrypoint=/bin/sh \
    alpine:3.20


# mkdir -p ./wms/xmonad/outro/
# cd ./wms/xmonad/outro
#
# # update stack
# sudo stack upgrade && stack init
# cp ../config.hs ./xmonad.hs
#
# # install local ghcx
# stack build
