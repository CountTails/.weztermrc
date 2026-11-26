#! /bin/bash

REPO=$(git rev-parse --show-toplevel)
TEST_DIR="$REPO/test"
TEST_LIBS="$TEST_DIR/lib"
TEST_MAIN="$TEST_DIR/main.lua"

LUAUNIT_REPO="https://github.com/bluebird75/luaunit.git"

# Obtain a copy of the latest luaunit if a local lib is not present
if [[ ! -f "$TEST_LIBS/luaunit.lua" ]]; then
  git clone --depth 1 $LUAUNIT_REPO /tmp/luaunit
  cp /tmp/luaunit/luaunit.lua $TEST_LIBS/luaunit.lua
  rm -rf /tmp/luaunit
  chmod -x $TEST_LIBS/luaunit.lua
fi

# Run the unit test suite
PKG_PATH="package.path = '$TEST_LIBS/?.lua;$TEST_LIBS/?/init.lua;$REPO/lua/?.lua;' .. package.path"
lua -e "$PKG_PATH" $TEST_MAIN --verbose
