#!/bin/sh

stringtester="
/usr/lib/libHSsimple-sendfile-0.2.32-67pvf2P6BMqW8RJrNUYXv-ghc9.2.8.so
/usr/lib/libHSrecv-0.1.0-BGLF4vbjR769fG701NJUHt-ghc9.2.8.so
/usr/lib/libHShttp2-4.1.0-2I5onMgeygY97UAOMC5Bos-ghc9.2.8.so
/usr/lib/libHStime-manager-0.0.1-LO3iblKx5j9A3vxYKWYDEx-ghc9.2.8.so
"

##ldd $(which hoogle) | grep "not found" | awk '{print $1}' | xargs -I{} bash -c "pacman -Qo '/usr/lib/{}' | awk '{print $5}' | tr '\n' ' ' | echo"
#pacman -Qo /usr/lib/libHSsimple-sendfile
#error: No package owns /usr/lib/libHSsimple-sendfile

#; pacman -Qo /usr/lib/libHSsimple-sendfile*
#/usr/lib/libHSsimple-sendfile-0.2.32-67pvf2P6BMqW8RJrNUYXv-ghc9.2.8.so is owned by haskell-simple-sendfile 0.2.32-50
#;

#program=$(readlink -f "$(which "$1")")
program=hoogle

xargs_full="awk -F- '{
    for (i = 1; i <= NF; i++) {
        if ($i ~ /^[0-9]/) {
            print substr($0, 1, index($0, $i) - 2);
            break;
        }
    }}'"

xargs_args="pacman -Qo '/usr/lib/{}*' | $xargs_full | tr '\n' ' ' "

ldd "$(which "$program")" \
    | head \
    | grep "not found" \
    | awk '{print $1}' \
    | xargs -I{} bash -c "echo {}"
    #| xargs -I{} bash -c "$xargs_args"
