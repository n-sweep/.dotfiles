#!/bin/env bash

url="lite.duckduckgo.com/lite?kd=-1&kp=-1&q=$(urlencode "$*")"
exec w3m "$url"
