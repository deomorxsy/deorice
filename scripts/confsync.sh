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


vim_setup() {

VIM_CONFIG_PATH="${HOME}/.vimrc"
VIM_DOTFILE_PATH_REPO_FILE="./.config/vim/vimrc"
VIM_DOTFILE_BAK="/tmp/vimrc-bak"

if ! cp "${VIM_CONFIG_PATH}" "${VIM_DOTFILE_BAK}" ; then
    echo "|> [ERROR]: could not create a backup file for the vimrc. Exiting now..."
    return 1
fi
    echo "|> [PASS]: successfully created a backup file for the vimrc. Proceeding..."

if [ -f "${VIM_CONFIG_PATH}"]; then
    if ! cp "${VIM_DOTFILE_PATH_REPO_FILE}" "${VIM_CONFIG_PATH}"; then
        echo "|> [ERROR]: could not copy the vimrc dotfile at the local repository to the system's vimrc at ${HOME}."
        echo

    fi

    if  !(! diff "${VIM_CONFIG_PATH}" "${VIM_DOTFILE_PATH_REPO_FILE}"); then
        # ==========
        echo "|> [ERROR]: the [VIM_CONFIG_PATH=${VIM_CONFIG_PATH}] differs from the local repository vimrc dotfile at [VIM_DOTFILE_PATH_REPO_FILE=${VIM_DOTFILE_PATH_REPO_FILE}.]"
        echo "|> [WARNING]: attempting to restore the backup vimrc file..."
        if ! cp "${VIM_DOTFILE_BAK}" "${VIM_CONFIG_PATH}"; then
            echo "|> [ERROR]: could not restore the backup vimrc file. Exiting now..."
            return 1
        fi
        echo "|> [PASS]: successfully restored the backup vimrc file. Exiting now..."
        # ==========
    fi
    echo "|> [PASS]: successfully copied the vimrc dotfile at the local repository to the system's vimrc at ${HOME}. Finished."
fi

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
USAGE: MODE="[-options]" . ./scripts/confsync.sh
            - vim_synch
            - neovim_synch
            - all
            - version
            - help
            - clean

eg,
MODE="-vim_synch"   . ./scripts/confsync.sh # synchronize vim dotfiles
MODE="-neovim_synch"  . ./scripts/confsync.sh # synchronize neovim dotfiles
MODE="-all"          . ./scripts/confsync.sh # synchronize all dotfiles
MODE="-version"      . ./scripts/confsync.sh # print program version
MODE="-help"         . ./scripts/confsync.sh # print help version
MODE="-clean"        . ./scripts/confsync.sh # clean program intermediate build step artifacts

See the man page and example file for more info.

END

}

print_version() {

SCRIPT_VER="|> script: [./scripts/confsync.sh]"
FUNCTION_VER="|> function: [print_version]"

 if [ "${PRINTA_VERBOSE}" = "1"]; then
    echo "=============="
    echo "${SCRIPT_VER}"
    echo "${FUNCTION_VER}"
    echo
fi
    echo
    echo "|> Version: confsync v1.0.0"
    echo
}

print_error() {

SCRIPT_PE="|> script: [./scripts/confsync.sh]"
FUNCTION_PE="|> function: [print_error]"

if [ "${PRINTA_VERBOSE}" = "1"]; then
    echo "=============="
    echo "${SCRIPT_PE}"
    echo "${FUNCTION_PE}"
    echo
fi

echo "|> Invalid option. Exiting now..."
print_usage
}

# Check the argument passed from the command line
if ! [ -z "${PRINTA_VERBOSE}" ] && [ "${PRINTA_VERBOSE}" = "1" ]; then
    PRINTA_VERBOSE="1" && export PRINTA_VERBOSE;

    if ! env | grep "PRINTA_VERBOSE"; then
        echo "|> [WARNING]: the [PRINTA_VERBOSE] pretty-printer variable was not set. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: the [PRINTA_VERBOSE] pretty-printer variable was set with success. Proceeding..."
fi


if ! [ -z "${MODE}" ] &&
    [ "${MODE}" = "-vim_synch"]    ||
    [ "${MODE}" = "-neovim_synch" ]   ||
    [ "${MODE}" = "-all" ]       ||
    [ "${MODE}" = "-help" ]      ||
    [ "${MODE}" = "-version" ]; then
    case "${MODE}" in
    "-vim_synch") vim_setup ;;
    "-neovim_synch") nvim_setup ;;
    "-all") build_all ;;
    "-help") print_help ;;
    "-version") print_version ;;
    *)
        print_error
        print_usage
        ;;
    esac

elif [ "${MODE}" = "help" ]     || [ "${MODE}" = "-h" ] || [ "${MODE}" = "--help" ]; then
    print_usage
elif [ "${MODE}" = "version" ]  || [ "${MODE}" = "-v" ] || [ "${MODE}" = "--version" ]; then
    printf "\n|> Version: confsync 1.0.0"
else
    print_error
fi




