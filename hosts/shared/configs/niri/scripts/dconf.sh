#!/usr/bin/env bash

OGDI="/org/gnome/desktop/interface"

dconf write "$OGDI/color-scheme" '"prefer-dark"'
dconf write "$OGDI/gtk-theme" '"phocus"'
dconf write "$OGDI/icon-theme" '"Qogir-dark"'
dconf write "$OGDI/cursor-theme" '"Simp1e"'
