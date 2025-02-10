FROM python:3.13-rc-alpine3.18 as builder

WORKDIR /tests
COPY ./requirements.txt .

ENV USER="myapp"
WORKDIR "/home/${USER}/app"

RUN <<EOF

#set -e

# install basic tools
apk upgrade && apk update && \
    apk add python3 py3-pip zstd xdg-utils \
        nsxiv libx11 imlib2 libxft musl libexif fontconfig


addgroup -g 1000 -S "${USER}" && \
adduser -s /bin/sh -u 1000 -G "${USER}" \
    -h "/home/${USER}" -D "${USER}" && \
su "${USER}" && cd || return && \
pip3 install --user --upgrade pip virtualenv --break-system-packages && \
export PATH=$HOME/.local/bin/:$PATH && \
virtualenv venv && source ./venv/bin/activate && \
python3 -m ensurepip --default-pip && \

# get the release, decompress with zst, tar, and attempt to install.
wget https://github.com/ankitects/anki/releases/download/25.02rc1/anki-25.02-linux-qt6.tar.zst
zstd -d ./anki-25.02-linux-qt6.tar.zst
tar -xvf anki-25.02-linux-qt6.tar
cd ./anki-25.02-linux-qt6 || return
. ./install.sh

#pip3 install --no-cache-dir -r ./requirements.txt && \

# always
deactivate

EOF


COPY . .
RUN ls -allhtr
RUN <<EOF
python_tests() {
for dir in /app/*; do
    if [ -d $dir ]; then
    pytest "$dir" >> /app/test_result_"$(basename "$dir")"_.txt 2>&1
    cd - || return
    elif [ -f "$dir" ]; then
        echo "A file $dir was found. Skipping..."
    fi
done
}

su "${USER}" && python_tests

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
CMD ["cat /tests/test_result_*_.txt"]
