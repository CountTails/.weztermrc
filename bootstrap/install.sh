#! /bin/bash

SRC_DIR=$(git rev-parse --show-toplevel)/lua
DST_DIR=~/.config/wezterm

# Check is the destination directory (~/.config/wezterm) exists and create it if it does not
if [[ ! -d "$DST_DIR" ]]; then
  echo "$DST_DIR does not exist; creating..."

  if ! mkdir -p -- "$DST_DIR"; then
    echo "Error: failed to create directory: $DST_DIR"
    exit 1
  fi
fi

# Ensure the directory is empty
if [[ -n "$(find "$DST_DIR" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
  echo "Error: directory is not empty: $DST_DIR" >&2
  exit 1
fi

# Copy the configuration files in `lua` to the destination directory
if ! cp -r -- "$SRC_DIR/" "$DST_DIR/"; then
  echo "Error: could not copy $SRC_DIR to $DST_DIR" >&2
  exit 1
fi

echo "OK: successfully installed the configuration in $SRC_DIR at $DST_DIR"
exit 0
