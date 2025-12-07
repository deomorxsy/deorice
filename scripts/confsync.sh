#!/bin/sh

cloud_setup() {
export PASSWD="${DRIVE_PASSWD}"

cp ../../dotfiles/.cvsignore ~/backup/gdrive/

}

nvim_setup() {

NEOVIM_CONFIG_PATH="${HOME}"/.config/nvim/
DOTFILE_PATH_REPO="./.config/nvim"

# always idempotent
mkdir -p "${DOTFILE_PATH_REPO}"

if [ -d "${DOTFILE_PATH_REPO}" ]; then
    cp -r "${DOTFILE_PATH_REPO}"/* "${NEOVIM_CONFIG_PATH}"
    printf "\n|> Neovim configuration synchronized with success! \o/ \n\n"
else
    printf "\n|> Error: Neovim configuration directory not found. Exiting now...\n\n"
fi


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



