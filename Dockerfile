FROM alpine:latest as build
ARG NEOVIM_VERSION=v0.5.0

RUN apk add --update --no-cache \
  git \
  gettext-tiny-dev \
  alpine-sdk build-base\
  libtool \
  automake \
  m4 \
  autoconf \
  linux-headers \
  unzip \
  ncurses ncurses-dev ncurses-libs ncurses-terminfo \
  clang \
  go \
  nodejs \
  xz \
  curl \
  make \
  cmake

WORKDIR /tmp

ENV CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF

RUN git clone --depth=1 --branch $NEOVIM_VERSION https://github.com/neovim/neovim.git && \
  cd neovim && \
  CMAKE_BUILD_TYPE=Release make && \
  make install DESTDIR=/tmp && \
  cd ../ && rm -rf neovim

FROM alpine:latest

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en

RUN apk add --update --no-cache \
  curl \
  git \
  go \
  gcc \
  g++ \
  libgcc

COPY --from=0 /tmp/usr /usr

RUN adduser -S neo -u 1000 -G users

USER neo

ENV TERM=xterm-256color
ENV HOME=/home/neo
ENV XDG_CONFIG_HOME=$HOME/.config

ENV PATH=$PATH:$HOME/go/bin
RUN GO111MODULE=on go get golang.org/x/tools/gopls@latest

RUN mkdir -p $XDG_CONFIG_HOME/nvim/plugin $XDG_CONFIG_HOME/nvim/after/plugin

RUN git clone --depth=1 https://github.com/wbthomason/packer.nvim $HOME/.config/nvim/pack/packer/start/packer.nvim
COPY neovim/init.vim $XDG_CONFIG_HOME/nvim
COPY neovim/lua $XDG_CONFIG_HOME/nvim/lua
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall'
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

WORKDIR /work

ENTRYPOINT nvim
