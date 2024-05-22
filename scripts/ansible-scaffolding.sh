#!/usr/bin/sh
#
# basic ansible project
# directory structure scaffolding
#
# PS: run from the project root dir
#
# sh and dash only supports = for equality comparison,
# so use that instead of the == in C-like languages..
#
# [ .. ] can't match globs. Case statements: [[ .. ]] or grep.
# In POSIX sh, [[ .. ]] is undefined. POSIX sh uses [ ] and test instead.

check_path=$(pwd | grep deorice | awk -F/ '{print $NF}')

if [ "$check_path" = 'deorice' ]; then
    cd ./scripts/playbooks/ || return


    mkdir -p inventories/production \
        inventories/staging \
        group_vars \
        host_vars \
        library \
        module_utils \
        filter_plugins \
        roles


    #declare -a dirs
    #
    # find every directory and print it jumping lines
    dirs_string="$(find . -type d -printf '%p\n')"


    # counter and iterator for first line number
    # this avoids creating a .gitkeep directly
    # into the playbook directory.
    counter=0
    target_iter=1

    # where index is each directory
    printf '%s' "$dirs_string" |
        while read -r index; do
            # increment counter
            counter=$((counter+1))

            # if the iteration is not in the first line,
            # create the gitkeep dotfile.
            if [ ! "$counter" -eq "$target_iter" ]; then
                #echo "$index"/.gitkeep
                touch "$index"/.gitkeep
            fi
        done

    #for x in "${!find_dirs[@]}"; do ls "$x"; done
    #touch "{$(find scripts/playbooks/ -type d -printf '%p,')}/.gitkeep"

    cd - || return
fi
