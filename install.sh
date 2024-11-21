#!/bin/bash

# Tạo symbolic link
ln -sf "$(pwd)/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/.config/nvim" ~/.config/nvim

echo "Configuration has been linked!"
