#!/bin/sh

set_env() {

    CCR_MODE="checker" . ./scripts/ccr.sh && \
    	docker compose -f ./compose.yml --progress=plain build jupynvim

}

set_env
