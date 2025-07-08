# Context: ./.config/nvim/other-apps/ipynb/
FROM alpine:3.20 as builder

WORKDIR /tests
COPY ./.config/nvim/other-apps/ipynb/requirements.txt .

ENV USER="nvim"

RUN <<EOF
apk upgrade && apk update && \
apk add --no-cache \
    build-base \
    libx11-dev \
    libxext-dev \
    libxres-dev \
    xorgproto \
    python3-dev \
    py3-pip \
    meson \
    ninja \
    cmake \
    pkgconfig \
    py3-setuptools \
    py3-wheel \
    p3-dev musl-dev linux-headers


    # apk add --no-cache gcc
    apk add --no-cache clang

    apk add --no-cache neovim python3 py3-pip py3-pkgconfig luarocks ripgrep git cmake nodejs npm libx11-dev




(
cat <<HMM
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
HMM
) > /etc/apk/repositories

apk add libxext libxext-dev libxres-dev ethtool
# zig: c compiler
# node: provider for nvim's treesitter
# python: provider for nvim

EOF


RUN <<EOF
set -e

USER="nvim"

# set python provider
addgroup -g 1000 -S "${USER}" && \
adduser -s /bin/sh -u 1000 -G "${USER}" \
    -h "/home/${USER}" -D "${USER}" && \

mkdir -p /home/"${USER}/.config/nvim/" && \
chown -R "$USER:$USER" /home/"${USER}"/.config && \
cd /home/"${USER}/.config/nvim/" && \

npm install -g tree-sitter-cli && \

su "${USER}" -c '
pip3 install --user --upgrade pip virtualenv --break-system-packages && \
export PATH=$HOME/.local/bin/:$PATH && \
virtualenv "$HOME"/.config/nvim/venv_nvim/neovim3 && source ./venv_nvim/neovim3/bin/activate && \
python3 -m ensurepip --default-pip && \
pip3 install --no-cache-dir -r /tests/requirements.txt && \


git clone https://github.com/deomorxsy/deorice.git
cp -r "$HOME"/.config/nvim/deorice/.config/* "$HOME"/.config/

cp ./deorice/other-apps/ipynb/treesitter.lua ./after/plugin/treesitter.lua


# nvim --headless -u NONE -c "luafile $dir/hullo.lua" -c ":qa" >> /test/test_result_"$(basename "$dir")"_.txt 2>&1
# nvim --headless -u NONE -c "lua os.execute('mkdir -p ./other-apps/ipynb/')" -c ":qa"

# -u NONE, which disables all plugins and configuration
# --no-plugin is implied by -u NONE
nvim --headless -c "lua print('Setting up Magma...')" \
    -c ":Lazy sync" \
    -c ":UpdateRemotePlugins" \
    -c ":MagmaInit python3" \
    -c ":qa"

deactivate

'
# pynvim

# set node provider
# todo: set user for local npm install
npm install -g nvim
npm install -g tree-sitter-cli


EOF


#USER 1000
#WORKDIR /$USER/rice/

COPY . .
RUN ls -allhtr
RUN <<EOF

#set_packer() {
#}

set_lazy()

set_coq()

nvim_tests() {
for dir in /test/*; do
    if [ -d $dir ]; then
    nvim --headless -u NONE -c "luafile $dir/hullo.lua" -c ":qa" >> /test/test_result_"$(basename "$dir")"_.txt 2>&1
    cd - || return
    elif [ -f "$dir" ]; then
        echo "A file $dir was found. Skipping..."
    fi
done
}

su "${USER}" && nvim_tests
EOF

ENTRYPOINT [ "nvim", "--headless", "-c" , "'so'", "-c", "'PackerSync'", " "${HOME}/.config/nvim/lua/user/packer.lua" " ]


# =========
# relay step
#
FROM alpine:3.20 as relay

COPY --from=builder /test/test_result_*_.txt .

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["cat /tests/test_result_*_.txt"]

