#!/bin/env bash

_have() { type "$1" &>/dev/null; }

OPENAI_API_KEY="$(head -1 "$HOME/.config/gpt/token")"
export OPENAI_API_KEY

! _have mods && echo "requires charmbracelet/mods" && exit 1

mods --status-text "BEEP BOOP" "$@"
