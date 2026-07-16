#!/bin/sh

cloud_setup() {
export PASSWD="${DRIVE_PASSWD}"

cp ../../dotfiles/.cvsignore ~/backup/gdrive/

}


vimdir_setup() {

# Basic Layout
VIMDIR_COLORS="$HOME/.vim/colors/"
VIMDIR_PLUGIN="$HOME/.vim/plugin/"
VIMDIR_FTDETECT="$HOME/.vim/ftdetect/"
VIMDIR_FTPLUGIN="$HOME/.vim/ftplugin/"
VIMDIR_INDENT="$HOME/.vim/indent/"
VIMDIR_COMPILER="$HOME/.vim/compiler/"
VIMDIR_AFTER="$HOME/.vim/after/"
VIMDIR_AUTOLOAD="$HOME/.vim/autoload/"
VIMDIR_DOC="$HOME/.vim/doc/"

export VIMDIR_COLORS
export VIMDIR_PLUGIN
export VIMDIR_FTDETECT
export VIMDIR_FTPLUGIN
export VIMDIR_INDENT
export VIMDIR_COMPILER
export VIMDIR_AFTER
export VIMDIR_AUTOLOAD
export VIMDIR_DOC

# make sure directories exist: idempotent.
mkdir -p "${VIMDIR_COLORS}"
mkdir -p "${VIMDIR_PLUGIN}"
mkdir -p "${VIMDIR_FTDETECT}"
mkdir -p "${VIMDIR_FTPLUGIN}"
mkdir -p "${VIMDIR_INDENT}"
mkdir -p "${VIMDIR_COMPILER}"
mkdir -p "${VIMDIR_AFTER}"
mkdir -p "${VIMDIR_AUTOLOAD}"
mkdir -p "${VIMDIR_DOC}"

}

nvim_setup() {

NEOVIM_CONFIG_PATH="${HOME}/.config/nvim/"
NEOVIM_DOTFILES_PATH_REPO="./.config/nvim"

# always idempotent
mkdir -p "${NEOVIM_DOTFILES_PATH_REPO}"

if [ -d "${NEOVIM_DOTFILES_PATH_REPO}" ]; then
    cp -r "${NEOVIM_DOTFILES_PATH_REPO}"/* "${NEOVIM_CONFIG_PATH}"
    printf "\n|> Neovim configuration synchronized with success! \o/ \n\n"
else
    printf "\n|> Error: Neovim configuration directory not found. Exiting now...\n\n"
fi


}


mpd_sync() {
MPD_CONFIG_PATH="${HOME}/.config/mpd/"
MPD_DOTFILES_PATH_REPO="./.config/audio/mpd"

# Always idempotent.
mkdir -p "${MPD_CONFIG_PATH}"
mkdir -p "${MPD_DOTFILES_PATH_REPO}"

echo "=============="
echo "|> Function Context: [audio_sync/mpd_sync]"

if ! [ -d "${MPD_DOTFILES_PATH_REPO}" ] && ! [ -d "${MPD_CONFIG_PATH}" ]; then
    echo "|----> [ERROR]: could not find either the [MPD_DOTFILES_PATH_REPO=${MPD_DOTFILES_PATH_REPO}] OR the [MPD_CONFIG_PATH=${MPD_COFIG_PATH}] directories. Exiting now..."
    return 1
fi
echo "|----> [PASS]: found the [MPD_DOTFILES_PATH_REPO=${MPD_DOTFILES_PATH_REPO}] directory. Proceeding..."

if ! cp -r "${MPD_DOTFILES_PATH_REPO}"/* "${MPD_CONFIG_PATH}"
    echo " |----> [Error]: could not copy local path repo mpd dotfiles to the [MPD_CONFIG_PATH=${MPD_CONFIG_PATH}]"
    return 1
fi
echo "|----> [PASS]: mpd configuration synchronized with success! ;)"


}

ncmpcpp_sync() {
NCMPCPP_CONFIG_PATH="${HOME}/.config/ncmpcpp/"
NCMPCPP_DOTFILES_PATH_REPO="./.config/audio/ncmpcpp"

echo "=============="
echo "|> Function Context: [audio_sync/ncmpcpp_sync]"

if ! [ -d "${ncmpcpp_DOTFILES_PATH_REPO}" ] && ! [ -d "${NCMPCPP_CONFIG_PATH}" ]; then
    echo "|----> [ERROR]: could not find either the [ncmpcpp_DOTFILES_PATH_REPO=${NCMPCPP_DOTFILES_PATH_REPO}] OR the [NCMPCPP_CONFIG_PATH=${NCMPCPP_COFIG_PATH}] directories. Exiting now..."
    return 1
fi
echo "|----> [PASS]: found the [NCMPCPP_DOTFILES_PATH_REPO=${NCMPCPP_DOTFILES_PATH_REPO}] directory. Proceeding..."

if ! cp -r "${ncmpcpp_DOTFILES_PATH_REPO}"/* "${NCMPCPP_CONFIG_PATH}"
    echo " |----> [Error]: could not copy local path repo ncmpcpp dotfiles to the [NCMPCPP_CONFIG_PATH=${NCMPCPP_CONFIG_PATH}]"
    return 1
fi
echo "|----> [PASS]: ncmpcpp configuration synchronized with success! ;)"

}

audio_sync() {

AUSY_ROP=""

ausy_builder() {
    if ! [ "not" in "${AUSY_ROP}" ]; then
    fi
}

if ! mpd_sync; then
    echo "|> [Error]: could not run the function [mpd_sync]. Exiting now..."
    return 1
fi
echo "|> [PASSED]: successfully ran the function [mpd_sync]. Proceeding..."

if ! ncmpcpp_sync; then
    echo "|> Error: could not run the function [ncmpcpp_sync]. Exiting now..."
    return 1
fi
echo "|> [PASSED]: successfully ran the function [ncmpcpp_sync]. Proceeding..."

}

print_usage() {
cat <<-END >&2
USAGE: confsync [-options]
                - nvim
                - help
                - version
eg,
confsync -nvim   # synchronize neovim configuration
confsync -help    # shows this help message
confsync -version # shows script version

See the man page and example file for more info.

END

}


# Check the argument passed from the command line
if [ "$MODE" = "synch" ] || [ "$MODE" = "-synch" ] || [ "$MODE" = "--synch" ] || [ "$MODE" = "--synchronize" ] ; then
    nvim_setup
elif [ "$MODE" = "help" ] || [ "$MODE" = "-h" ] || [ "$MODE" = "--help" ]; then
    print_usage
else
    printf "\n|> Invalid function name. Please specify one of: [function1, nvim, help]\n\n"
    print_usage
fi



