#!/usr/bin/bash
#

exclude_path=("${USER}.local/share/containers/", "${USER}.local/share/Trash")

basename "${exclude_path[@]}"
#listdir=$(find "${USER}.local/share/" -maxdepth 1 -type d ! -name "$(basename "${exclude_path[@]}")")

#echo "$listdir"
#for dir in $listdir; do
#    echo "disk usage in $dir:"
#    du -h -x --max-depth=1 "$dir" # -x for different filesystems
#done


