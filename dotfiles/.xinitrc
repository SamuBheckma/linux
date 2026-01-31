#!/usr/bin/env bash
# .xinitrc - Script para iniciar X11 com i3

export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8

# Ativa NumLock
numlockx on 2>/dev/null || true

# Define wallpaper (opcional)
# feh --bg-fill ~/path/to/wallpaper.jpg &

# Compositor para efeitos (opcional)
# picom &

# i3 window manager
exec i3
