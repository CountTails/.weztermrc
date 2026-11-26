#! /bin/bash

REPO_DIR=$(git rev-parse --show-toplevel)

CONFIG_INSTALL_DIR="$HOME/.config/wezterm"
ASSETS_INSTALL_DIR="$HOME/.local/share/wezterm/assets"

CONFIG_SRC_DIR="$REPO_DIR/lua"
ASSETS_SRC_DIR="$REPO_DIR/assets"

SRC=""
DST=""
FORCE=false

# Parse the install target argument
case "${1:-}" in
  config) read -r SRC DST <<< "$CONFIG_SRC_DIR $CONFIG_INSTALL_DIR" ;;
  assets) read -r SRC DST <<< "$ASSETS_SRC_DIR $ASSETS_INSTALL_DIR" ;;
  *) echo "Must specify target: [config, assets]" >&2 && exit 2 ;;
esac  


# Parse the `--force` option
case "${2:-}" in 
  --force)
  FORCE=true
  shift
  ;;
esac

# Check for an existing $DST and bail if force is not specified
if [[ -d $DST && "$FORCE" != true ]]; then
  echo "Error: $DST exists and --force option not specified" >&2
  exit 1
fi

# Remove existing $DST if force option was specified
if [[ "$FORCE" != false ]]; then
  echo "Warn: forceful install will remove existing $DST"

  if ! rm -vrf -- "$DST"; then
    echo "Error: could not remove $DST in preparation for install" >&2
    exit 1
  fi
fi

# Create $DST to prepare for copy installation
if [[ ! -d "$DST" ]]; then
  echo "$DST does not exist; creating... "

  if ! mkdir -vp -- "$DST"; then
    echo "Error: failed to create $DST" >&2
    exit 1
  fi
fi

# Check that $DST is an empty directory
if [ ! -z "$(ls -A $DST)" ]; then
  echo "Error: $DST is not an empty directory" >&2
  exit 1
fi

# Copy children of $SRC to $DST
if ! cp -a -- "$SRC/." "$DST"; then
  echo "Error: could not copy $SRC to $DST" >&2
  exit 1
fi

echo "OK: children of $SRC copied to $DST"
exit 0
