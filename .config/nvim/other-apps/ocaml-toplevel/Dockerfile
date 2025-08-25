FROM alpine:3.20 AS builder


USER root

WORKDIR /app/

RUN <<EOF
apk upgrade && apk update && \
    apk add musl-dev ocaml ocaml-compiler-libs ocaml-findlib opam dune make neovim
    # musl-dev is needed for some headers for dune, ocamlbuild and ocamlfind builds
    # apk add dune ocaml musl-dev git autoconf automake zig ocaml-compiler-libs make ocaml-findlib rpm

mkdir -p /app/ && cd /app/ || return

(
cat <<HMM
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
HMM
) > /etc/apk/repositories

apk add ocaml-utop supermin

RKD_USER=rkd
# create user and group
addgroup -g 1000 -S "${RKD_USER}" && \
adduser -s /bin/sh -u 1000 -G "${RKD_USER}" \
    -h "/home/${RKD_USER}" -D "${RKD_USER}" && \
su "${RKD_USER}" -c "

mkdir -p "$HOME/app/"
cd "$HOME/app/" || return

# make sure $HOME/.opam is not used yet
rm -rf "$HOME/.opam"
# initialise opam
opam init --auto-setup --disable-sandboxing --yes --bare

# setup opam switches with the utop toplevel/REPL
## ensure musl-dev is installed.
opam switch create utop --yes && \
    eval $(opam env --switch=utop)

# utop

# create ocaml project with opam and dune
opam exec -- dune init proj --kind=lib src

# git clone https://github.com/libguestfs/supermin.git

# set zig cc
# export CC="zig cc"
# export CXX="zig c++"
# export CFLAGS="-target x86_64-linux-musl"
# export CXXFLAGS="-target x86_64-linux-musl"
# export LDFLAGS="-target x86_64-linux-musl"

# autoreconf -i
"

EOF
# with git clone supermin

# USER rkd
# ENV USER USER
#
# RUN <<EOF
#
# USER=${USER:-rkd}
# # create user and group
# addgroup -g 1000 -S "${USER}" && \
# adduser -s /bin/sh -u 1000 -G "${USER}" \
#     -h "/home/${USER}" -D "${USER}" && \
# su "${USER}"
#
# EOF
#

# run tests
WORKDIR /app
COPY . .
RUN ls -allhtr
RUN <<EOF
ocaml_tests() {
for dir in /app/*; do
    if [ -d $dir ]; then
    cd "$dir" && dune runtest && dune clean && \
    cat ./stack.yaml && \
    stack build --test >> /app/test_result_"$(basename "$dir")"_.txt 2>&1
    cd - || return
    elif [ -f $dir ]; then
        echo "A file $dir was found. Skipping..."
    fi
done
}
ocaml_tests
EOF


# ======================
# 2. Relay Step
# ======================
FROM alpine:3.20 as relay

WORKDIR /tests

COPY --from=builder /app/test_result_*_.txt .

# set command to be executed when the container starts
ENTRYPOINT ["/bin/sh", "-c"]

# set argument to be fed to the entrypoint
#CMD ["apk upgrade && apk update && apk add dune ocaml musl-dev"]
# C
