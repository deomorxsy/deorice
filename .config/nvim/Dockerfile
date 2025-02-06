FROM alpine:3.19 as builder

WORKDIR /tests
ENV USER="nvim"

RUN <<EOF
apk upgrade && apk update && \
     add --no-cache neovim python3 luarocks ripgrep git zig
EOF


RUN <<EOF
set -e

# set python provider
addgroup -g 1000 -S "${USER}" && \
adduser -s /bin/sh -u 1000 -G "${USER}" \
    -h "/home/${USER}" -D "${USER}" && \
su "${USER}" && \
mkdir -p "${USER}/.config/nvim/" && \
cd "${USER}/.config/nvim/" && \
pip3 install --user --upgrade pip virtualenv --break-system-packages && \
export PATH=$HOME/.local/bin/:$PATH && \
virtualenv venv && source ./venv/bin/activate && \
python3 -m ensurepip --default-pip && \
pip3 install --no-cache-dir -r pynvim && \
#./requirements.txt && \

deactivate

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

