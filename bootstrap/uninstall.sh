#! /bin/bash

CONFIG_INSTALL_DIR="$HOME/.config/wezterm"
ASSETS_INSTALL_DIR="$HOME/.local/share/wezterm/assets"

DST=""
FORCE=false

# Parse the install target argument
case "${1:-}" in
  config) DST=$CONFIG_INSTALL_DIR ;;
  assets) DST=$ASSETS_INSTALL_DIR ;;
  *) echo "Must specify target: [config, assets]" >&2 && exit 2 ;;
esac  

# Parse the `--force` option
case "${2:-}" in
--force)
    FORCE=true
    shift
    ;;
esac

# Check that $DST exists
if [[ ! -d "$DST" ]]; then
  echo "Error no such directory ($DST)" >&2
  exit 1
fi

# Require confirmation unless explicitly skipped
if [[ "$FORCE" != true ]]; then
  printf 'Warning: "%s" will be removed permanently. Continue [y/N] ' "$DST"
  read -r confirmation

  case "$confirmation" in
    y | Y | yes | YES | Yes)
      ;;
    *)
      echo "Operation cancelled."
      exit 1
      ;;
  esac
fi

# Remove $DST
if ! rm -rvf -- "$DST"; then
  echo "Error: failed to remove directory ($DST)" >&2
  exit 1
fi

echo "OK: removed $DST successfully"
exit 0
