#!/usr/bin/sh
#
# ccr: check container runtime
# depends on systemd

registry() {
    #checker
    EXISTS_COMMAND=$( command -v podman >/dev/null 2>&1 )

    if [ $? -eq 1 ]; then
        podman run -d -p 5000:5000 --name registry registry:latest
        podman start registry
    else
        docker run -d -p 5000:5000 --name registry registry:latest
        docker start registry
    fi

    curl -s -i -X GET http://registry.localhost:5000/v2/_catalog | grep mock_ist

}

podman_compose() {
# systemd creates the podman UNIX socket under /run/user/1000/podman/
# that have a File Descriptor
systemctl --user start podman.socket

# if isn't already set, replace the DOCKER_HOST environment variable for the podman UNIXsocket
if [ -z "$DOCKER_HOST" ]; then
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
fi

# curl acts as a client making a request to the systemd's socket unit file (Podman API Socket),
# which triggers the podman service unit file. podman.service inherits the socket File Descriptor
# and accept connection; this is an instance of a podman process in running state.
curl -H "Content-Type: application/json" --unix-socket "$XDG_RUNTIME_DIR/podman/podman.sock" http://127.0.0.1/_ping
printf "\n\n"
# source this file before running docker compose
####

#docker compose -f ./oci/container-compose.yml build
}

checker() {
    # exists_wgh=$(which podman 2>&1 | grep -o "no" | head -n 1)
    EXISTS_COMMAND=$( command -v podman >/dev/null 2>&1 )

    # bash square bracket eval to check for empty expanded variable in a string,
    # AND if the podman binary have a path.
    if [ "$EXISTS_COMMAND" = '1' ]; then
        echo 'Using default DOCKER_HOST...'
        return
    # if true, command with the v flag outputs a line.
    elif $EXISTS_COMMAND; then
        echo 'Podman found. Invoking podman_compose...'
        # hook to set podman service (systemd socket unit file) as DOCKER_HOST
        podman_compose
        return
    fi
}

print_usage() {
cat <<-END >&2
USAGE: ccr [-options]
                - checker
                - version
                - help
eg,
ccr -checker   # runs qemu pointing to a custom initramfs and kernel bzImage
ccr -version # shows script version
ccr -help    # shows this help message

See the man page and example file for more info.

END

}


# Check the argument passed from the command line
if [ "$CCR_MODE" = "-checker" ] || [ "$CCR_MODE" = "--checker" ] || [ "$CCR_MODE" = "checker" ]; then
    checker
elif [ "$1" = "help" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    print_usage
elif [ "$1" = "version" ] || [ "$1" = "-v" ] || [ "$1" = "--version" ]; then
    printf "version"
else
    echo "Invalid function name. Please specify one of: function1, function2, function3"
    print_usage
fi


