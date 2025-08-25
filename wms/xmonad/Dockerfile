FROM alpine:3.20 AS builder

# Add ghcup's bin directory to the PATH so that the versions of GHC it builds
# are available in the build layers
ENV GHCUP_INSTALL_BASE_PREFIX=/
ENV PATH=/.ghcup/bin:$PATH

# Install the basic required dependencies to run 'ghcup' and 'stack'
# bash and shadow needed for stack --docker
# openssh-client needed for stack private packages
# binutils-gold needed for ld.gold
# zlib-static is just a common dependency
RUN apk upgrade --no-cache &&\
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
        zlib-static

# Download, verify, and install ghcup
RUN echo "Downloading and installing ghcup" &&\
    GHCUP_VERSION="0.1.30.0" &&\
    GHCUP_SHA256="fea4499d0cbdf71c554bfb7febebb81d1bcd09a4c4cfb7a90905ef9bff4931cb  /usr/bin/ghcup" &&\
    cd /tmp &&\
    wget -O /usr/bin/ghcup "https://downloads.haskell.org/~ghcup/${GHCUP_VERSION}/x86_64-linux-ghcup-${GHCUP_VERSION}" &&\
    if ! echo -n "${GHCUP_SHA256}" | sha256sum -c -; then \
        echo "ghcup checksum failed" >&2 &&\
        exit 1 ;\
    fi ;\
    chmod +x /usr/bin/ghcup

# 20 Oct 2024 GHC 9.8.3 -> 9.8.2
ARG GHC_VERSION=9.6.6
RUN ghcup install ghc $GHC_VERSION &&\
    ghcup set ghc $GHC_VERSION

# june 2024
ARG CABAL_VERSION=3.12.1.0
RUN ghcup install cabal $CABAL_VERSION &&\
    ghcup set cabal $CABAL_VERSION

# v3.1.1 2024-07-28
ARG STACK_VERSION=3.1.1
RUN ghcup install stack $STACK_VERSION &&\
    ghcup set stack $STACK_VERSION &&\
    stack config set system-ghc --global true


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
