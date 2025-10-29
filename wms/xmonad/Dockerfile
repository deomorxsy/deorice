FROM alpine:3.20 AS builder
FROM alpine:3.20 AS builder

# Add ghcup's bin directory to the PATH so that the versions of GHC it builds
# are available in the build layers
ENV GHCUP_INSTALL_BASE_PREFIX=/
#ENV PATH=/.ghcup/bin:$PATH
ENV PATH=/home/xmonad/.ghcup/bin/:/.ghcup/bin:$PATH
# Install the basic required dependencies to run 'ghcup' and 'stack'
# bash and shadow needed for stack --docker
# openssh-client needed for stack private packages
# binutils-gold needed for ld.gold
# zlib-static is just a common dependency
RUN <<EOF
apk upgrade --no-cache &&\
    apk add --no-cache \
        curl \
        gcc \
        g++ \
        gmp-dev \
        ncurses-dev \
        libffi-dev \
        zlib-dev \
        make \
        xz \
        tar \
        perl \
        bash \
        shadow \
        openssh-client \
        binutils-gold \
        zlib-static \
        gpg gpg-agent \
        libx11-dev libxft-dev libxinerama-dev libxrandr-dev libxscrnsaver-dev
        # libxss-dev


# setup keys to check the binaries
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 7D1E8AFD1D4A16D71FADA2F2CCC85C0E40C06A8C
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys FE5AB6C91FEA597C3B31180B73EDE9E8CFBAEF01
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 88B57FCF7DB53B4DB3BFA4B1588764FBE22D19C4
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys EAF2A9A722C0C96F2B431CA511AAD8CEDEE0CAEF


EOF

# Download, verify, and install ghcup
# as of 17-May-2025, the newest version was 0.1.50.2
# https://downloads.haskell.org/~ghcup/0.1.50.2/
# 0.1.30.0 -> 0.1.50.2
# checksum for version 0.1.30.0: GHCUP_SHA256="fea4499d0cbdf71c554bfb7febebb81d1bcd09a4c4cfb7a90905ef9bff4931cb  /usr/bin/ghcup" &&\
# checksum for version 0.1.50.2: ff6288df9758211372d8242fe830d8e6be6a8365d9406f1c9bde144b7e744143

# ff6288df9758211372d8242fe830d8e6be6a8365d9406f1c9bde144b7e744143  ./x86_64-linux-ghcup-0.1.50.2

RUN <<EOF

# manually setup ghcup
echo "Downloading and installing ghcup" &&
    GHCUP_VERSION="0.1.50.2" &&
    GHCUP_SHA256="ff6288df9758211372d8242fe830d8e6be6a8365d9406f1c9bde144b7e744143  /usr/bin/ghcup" &&
    cd /tmp &&
    wget -O /usr/bin/ghcup "https://downloads.haskell.org/~ghcup/${GHCUP_VERSION}/x86_64-linux-ghcup-${GHCUP_VERSION}" &&
    if ! echo -n "${GHCUP_SHA256}" | sha256sum -c -; then
        echo "ghcup checksum failed" >&2
        # exit 1 ;\
    else
        chmod +x /usr/bin/ghcup
    fi ;
EOF

# 9.6.6 -> 9.12.2 latest (26 aug 2025)
ARG GHC_VERSION=9.12.2
# 3.12.1.0 -> 3.16.0.0 latest
ARG CABAL_VERSION=3.16.0.0
# 3.1.1  2024-07-28 -> 3.7.1 2025-08-26
ARG STACK_VERSION=3.7.1

RUN <<EOF


GHC_VERSION=9.12.2
CABAL_VERSION=3.16.0.0
STACK_VERSION=3.7.1
XMONAD_USER="xmonad"
XMONAD_VERSION="0.18.0-76"

getent group "${XMONAD_USER}" > /dev/null || addgroup --gid 1000 "${XMONAD_USER}"

XMONAD_GID=$(getent group "${XMONAD_USER}" | cut -d: -f3)

getent passwd "${XMONAD_USER}" > /dev/null || \
adduser --shell /bin/bash \
    --uid 1000 \
    -G "xmonad" \
    --gecos "" \
    --disabled-password \
    --home "/home/${XMONAD_USER}" \
    "${XMONAD_USER}"

mkdir -p /home/${XMONAD_USER}/app/ &&  \

chown -R $XMONAD_USER:$XMONAD_USER /home/${XMONAD_USER}/app/  &&

su ${XMONAD_USER} -c '

GHC_VERSION=9.12.2
CABAL_VERSION=3.16.0.0
STACK_VERSION=3.7.1
XMONAD_USER="xmonad"
XMONAD_VERSION="0.18.0-76"

# Add directory to path
PATH=/home/xmonad/.ghcup/bin/:$PATH
PATH=/home/xmonad/.local/bin/:$PATH

# setup ghc
if ! ( ghcup install ghc $GHC_VERSION &&
    ghcup set ghc $GHC_VERSION ); then

    printf "\n|> it was not possible to setup ghc."
else
    printf "\n|> ghc was successfully installed.\n"
fi

# setup cabal
# if ! (ghcup install cabal $CABAL_VERSION &&
#     ghcup set cabal $CABAL_VERSION); then
#
#     printf "\n|> it was not possible to setup cabal."
# else
#     printf "\n|> cabal was successfully installed.\n"
# fi


# setup stack
if ! (ghcup install stack $STACK_VERSION &&
    ghcup set stack $STACK_VERSION &&
    stack config set system-ghc --global true); then

    printf "\n|> it was not possible to setup stack.\n"
 else
    printf "\n|> stack was successfully installed.\n"
fi


# ghcup install cabal 3.16.0.0
# ghcup install stack 3.7.1


# cabal update
# cabal install

# sync custom config
cp -r /app/* "${HOME}/app/"
cd "${HOME}/app/"

# setup stack
stack install xmonad xmonad-contrib
stack init
stack build
stack install


'

#
EOF


# run tests
WORKDIR /app
COPY . .
RUN ls -allhtr
RUN <<EOF
haskell_tests() {
for dir in /app/*; do
    if [ -d $dir ]; then
    cd "$dir" && stack init --force && \
    cat ./stack.yaml && \
    stack build --test >> /app/test_result_"$(basename "$dir")"_.txt 2>&1
    cd - || return
    elif [ -f $dir ]; then
        echo "A file $dir was found. Skipping..."
    fi
done
}
haskell_tests
EOF

#RUN cd /app/hello-world/ && ls -allhtr
#RUN stack init && cat ./stack.yaml
#RUN stack build --test >> /app/test_result.txt 2>&1

# stack test
#> /app/test_result.txt 2>&1


# ======================
# 2. Relay Step
# ======================
FROM alpine:3.20 as relay

WORKDIR /tests

COPY --from=builder /app/test_result_*_.txt .

# set command to be executed when the container starts
ENTRYPOINT ["/bin/sh", "-c"]

# set argument to be fed to the entrypoint
CMD ["printf \"===== UNIT TEST =====\\n\\n\" && for index in /tests/*; do cat $index && echo && echo done"]
