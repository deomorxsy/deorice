#!/bin/sh
ALL_WEBM="$(find ./ \( -iname '*.webm' \))"
export ALL_WEBM
DAVEZ=""
(
    cat <<"EOF"

def() {
if [ -z "${ALL_WEBM}" ]; then
    echo "|> Error: could not locate any webms. Exiting now..."
    return 1
fi
echo "|> Sucessfully located webms. ...PASSED" && echo

if ! echo "${DAVEZ}" | grep webm; then
    echo "|> Video input is not a webm. Exiting now..."
    return 1
fi
echo "|> Sucessfully recognized the video input as a webm. ...PASSED"

if [ -z "${DAVEZ}" ]; then
    echo "|> Error: DAVEZ is not ready."
    return 1
fi
echo "|> Sucessfully recognized DAVEZ as ready. ...PASSED"

if ! ffmpeg -i "${DAVEZ}" \
    -c:v libx264 \
    -preset slow \
    -crf 22 \
    -c:a aac \
    -b:a 128k \
    "$(echo "${DAVEZ}" | sed 's/webm/mp4/g')"; then
echo "|> Error: could not convert webm video to mp4 using FFMPEG. Exiting now..."
return 1
fi
echo "|> Sucessfully converted webm to mp4 with FFMPEG. Exiting now..."

echo && echo "|> DONE. mp4 video is ready!" && echo
}

def

EOF
) | tee ./ffmpeg-script.sh && chmod +x ./ffmpeg-script.sh

runner() {

    ALL_WEBM="$(find ./ \( -iname '*.webm' \))"
    export ALL_WEBM

    for jooj in $ALL_WEBM; do
        DAVEZ="$jooj"
        export DAVEZ
        if ! (/bin/sh -c "./ffmpeg-script.sh" "${DAVEZ}"); then
            echo "|> Error: it was not possible to resolve dependency list for [$jooj]. Exiting now..."
            return 1
        fi
        echo "|> Sucessfully resolved dependency list for [$jooj]. ...PASSED"
    done

    DAVEZ=""
    export DAVEZ

}

print_usage() {
    cat <<-END >&2
USAGE: batch.sh [-options]
                - runner
                - version
                - help
eg,
batch-vids -runner # setup the full runner for batch-vids
batch-vids -help    # shows this help message
batch-vids -version # shows script version

or,
MODE="runner"  . ./batch.sh   # setup the full runner for batch-vids

See the man page and example file for more info.

END

}

version() {
    echo "|> Version: batch-sh 1.0.0"
}

helper() {
    print_usage
}

# Check the argument passed from the command line
if ! [ -z "${MODE}" ] &&
    [ "${MODE}" = "help" ] ||
    [ "${MODE}" = "version" ] ||
    [ "${MODE}" = "runner" ]; then
    case "${MODE}" in
    "help") helper ;;
    "version") version ;;
    "runner") runner ;;
    *)
        echo "Invalid option. Please specify one of: runner help version"
        print_usage
        ;;
    esac
else
    echo "Invalid function name. Please specify one of the available functions:"
    print_usage
fi
