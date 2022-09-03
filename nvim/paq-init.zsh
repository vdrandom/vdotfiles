#!/usr/bin/env zsh
SRC=https://github.com/savq/paq-nvim.git
DST=$HOME/.local/share/nvim/site/pack/paqs/start/paq-nvim

git clone --depth=1 $SRC $DST
