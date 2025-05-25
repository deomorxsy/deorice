#!/bin/sh
#
#
#

cloud_setup() {
PASSWD="{{DRIVE_PASSWD}}"

cp ../../dotfiles/.cvsignore ~/backup/gdrive/

}

nvim_setup() {

mkdir -p "$HOME"/.config/nvim/

if [ -d ./.config/nvim/ ]; then
    cp -r ./.config/nvim/* "$HOME"/.config/nvim/
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
if [ "$1" = "nvim" ] || [ "$1" = "-nvim" ] || [ "$1" = "--nvim" ] || [ "$1" = "--neovim" ] ; then
    nvim_setup
elif [ "$1" = "help" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    print_usage
else
    printf "\n|> Invalid function name. Please specify one of: [function1, nvim, help]\n\n"
    print_usage
fi



