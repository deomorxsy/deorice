#!/bin/sh

set_env() {

    CCR_MODE="checker" . ./scripts/ccr.sh && \
    	docker compose -f ./compose.yml --progress=plain build jupynvim

}

#set_env

entrypoint() {
nvim --headless \
    -c "lua print('Lazy syncing + jupytext test')" \
    -c 'Lazy sync' \
    -c 'UpdateRemotePlugins' \
    -c "edit $NOTE" \
    -c 'write' \
    -c 'quitall'
}

core_routine() {

apk upgrade && \
    apk update && \
    apk add --no-cache build-base linux-headers \
        neovim luarocks git nodejs npm \
        libx11-dev xorgproto \
        clang meson ninja cmake pkgconfig ethtool imagemagick


(
cat <<HMM
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
HMM
) > /etc/apk/repositories

apk add libxext libxext-dev libxres-dev

}

build() {

if ! core_routine; then
    echo "|> [ERROR]: could not run [core_routine]. Exiting now..."
    return 1
fi
    echo "|> [PASS]: successfully ran [core_routine]. Proceeding..."

set -e

NVIM_USER="nvim"

# Copy files to /test beforehand
mkdir -p /tests/
chown -R $NVIM_USER:$NVIM_USER /tests/


# set python provider
addgroup -g 1000 -S "${NVIM_USER}" && \
adduser -s /bin/sh -u 1000 -G "${NVIM_USER}" \
    -h "/home/${NVIM_USER}" -D "${NVIM_USER}" && \

mkdir -p /home/"${NVIM_USER}/.config/nvim/" && \
chown -R "$NVIM_USER:$NVIM_USER" /home/"${NVIM_USER}"/.config && \
cd /home/"${NVIM_USER}/.config/nvim/" && \

npm install -g tree-sitter-cli && \


su "${NVIM_USER}" -c '
export PATH=$HOME/.local/bin/:$PATH && \
pip3 install --user --upgrade pip virtualenv --break-system-packages && \
virtualenv "$HOME"/.config/nvim/venv_nvim/neovim3 && source ./venv_nvim/neovim3/bin/activate && \
python3 -m ensurepip --default-pip && \
pip3 install --no-cache-dir -r /tests/requirements.txt && \


git clone https://github.com/deomorxsy/deorice.git
cp -r "$HOME"/.config/nvim/deorice/.config/* "$HOME"/.config/

cp ./deorice/.config/nvim/other-apps/ipynb/treesitter.lua ./after/plugin/treesitter.lua
cp ./deorice/.config/nvim/other-apps/ipynb/lazy.lua ./lua/config/lazy.lua

rm ./after/plugin/lean.lua


NOTE=/tests/pyarrow_livy_test.ipynb

# source ./venv_nvim/neovim3/bin/activate

nvim --headless \
    -c "lua print('Lazy syncing + jupytext test')" \
    -c 'Lazy sync' \
    -c 'UpdateRemotePlugins' \
    -c "edit $NOTE" \
    -c 'write' \
    -c 'quitall'

# nvim --headless -u NONE -c "luafile $dir/hullo.lua" -c ":qa" >> /test/test_result_"$(basename "$dir")"_.txt 2>&1
# nvim --headless -u NONE -c "lua os.execute('mkdir -p ./other-apps/ipynb/')" -c ":qa"

# -u NONE, which disables all plugins and configuration
# --no-plugin is implied by -u NONE
nvim --headless -c "lua print('Setting up Magma...')" \
    -c ":Lazy sync" \
    -c ":UpdateRemotePlugins" \
    -c ":MagmaInit python3" \
    -c ":qa"

deactivate

'
# pynvim

# set node provider
# todo: set user for local npm install
npm install -g nvim
npm install -g tree-sitter-cli



}

print_usage() {
    cat <<-END >&2
USAGE: jupynvim.sh.sh [-options]
                - core_routine
                - build
                - entrypoint
                - clean
                - version
                - help
eg,
MODE="core_routine" . ./scripts/jupynvim.sh.sh   # installs system-wide dependencies inside the container
MODE="build"        . ./scripts/jupynvim.sh.sh   # build the app and execute as cells inside jupyter with nvim
MODE="entrypoint"   . ./scripts/jupynvim.sh.sh   # runs the PoC post-build, inside the container
MODE="clean"        . ./scripts/jupynvim.sh.sh   # clean intermediate compiler files
MODE="version"      . ./scripts/jupynvim.sh.sh   # shows script version
MODE="help"         . ./scripts/jupynvim.sh.sh   # shows this help message

See the man page and example file for more info.

END



}

print_version() {

    SCRIPT_VER="|> script: [./scripts/jupynvim.sh]"
    FUNCTION_VER="|> function: [print_version]"

    if [ "${JUPYNVIM_SETUP_VERBOSE}" = "1" ]; then
        echo "=============="
        echo "${SCRIPT_VER}"
        echo "${FUNCTION_VER}"
        echo
    fi
    echo
    echo "|> Version: jupynvim v1.0.0"
    echo
}

print_error() {

    SCRIPT_PE="|> script: [./scripts/jupynvim.sh]"
    FUNCTION_PE="|> function: [print_error]"

    if [ "${JUPYNVIM_SETUP_VERBOSE}" = "1" ]; then
        echo "=============="
        echo "${SCRIPT_PE}"
        echo "${FUNCTION_PE}"
        echo
    fi

    echo "|> Invalid option. Exiting now..."
    #print_usage
}

# Check the argument passed from the command line
if ! [ -z "${JUPYNVIM_SETUP_VERBOSE}" ] && [ "${JUPYNVIM_SETUP_VERBOSE}" = "1" ]; then
    JUPYNVIM_SETUP_VERBOSE="1" && export JUPYNVIM_SETUP_VERBOSE

    if ! env | grep "JUPYNVIM_SETUP_VERBOSE"; then
        echo "|> [WARNING]: the [JUPYNVIM_SETUP_VERBOSE] pretty-printer variable was not set. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: the [JUPYNVIM_SETUP_VERBOSE] pretty-printer variable was set with success. Proceeding..."
fi

if ! [ -z "${MODE}" ] &&
    [ "${MODE}" = "core_routine" ] ||
    [ "${MODE}" = "build" ] ||
    [ "${MODE}" = "entrypoint" ] ||
    [ "${MODE}" = "tests" ] ||
    [ "${MODE}" = "clean" ]; then
    case "${MODE}" in
    "core_routine") core_routine ;;
    "build") build ;;
    "entrypoint") entrypoint ;;
    "clean") clean ;;
    *)
        print_error
        print_usage
        ;;
    esac

elif [ "${MODE}" = "help" ] || [ "${MODE}" = "-h" ] || [ "${MODE}" = "--help" ]; then
    print_usage
elif [ "${MODE}" = "version" ] || [ "${MODE}" = "-v" ] || [ "${MODE}" = "--version" ]; then
    print_version
else
    print_error
    print_usage
fi
