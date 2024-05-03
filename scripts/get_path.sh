#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

eval "$(jq -r '@sh "FP=\(.file_path) HOME=\(.home_dir) USER=\(.user_name)"')"

FullPath="/$HOME/$USER/$FP"

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg fp "$FullPath" --arg hm "$HOME" '{"path":$fp, "home":$hm}'