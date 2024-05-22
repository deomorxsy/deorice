FROM alpine:3.19

RUN apk add --no-cache neovim


USER 1000
WORKDIR /$USER/rice/

COPY . .

RUN ./deorice/

ENTRYPOINT [ "nvim", "--headless", "-c" , "'so'", "-c", "'PackerSync'", " "${HOME}/.config/nvim/lua/user/packer.lua" " ]
