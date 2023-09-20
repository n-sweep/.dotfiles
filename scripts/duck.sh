#!/bin/env bash

query=$(~/.dotfiles/scripts/urlencode.sh "$*")
url="lite.duckduckgo.com/lite?q=$query"
exec w3m "$url"
