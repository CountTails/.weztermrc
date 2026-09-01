#! /bin/bash

SKIP_CONFIRMATION=false
DST_DIR=~/.config/wezterm

# Parse the `--skip-confirmation` option
case "${1:-}" in
--skip-confirmation)
  SKIP_CONFIRMATION=true
  shift
  ;;
esac

# Check that the directory exists
if [[ ! -d "$DST_DIR" ]]; then
  echo "Error: directory does not exist: $DST_DIR" >&2
  exit 1
fi

# Require confirmation unless explicitly skipped
if [[ "$SKIP_CONFIRMATION" != true ]]; then
  printf 'Warning: "%s" will be removed recursively. Continue? [y/N] ' "$DST_DIR"
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

# Remove the directory
if ! rm -rf -- "$DST_DIR"; then
  echo "Error: failed to remove directory: $DST_DIR" >&2
  exit 1
fi

echo "OK: configuration successfully removed"
exit 0
