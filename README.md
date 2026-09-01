# My Wezterm configuration

## Introduction

This repository provides the configuration files that I use to run the ![Wezterm Terminal Emulator](https://wezterm.org).

**Key Features**

- Options values managed exclusively in Lua.
- Configuration applied in extensible and flexible manner.
- Deployable standalone with no required plugins and only what is included with wezterm.

**Prerequisites**

Before getting started, make sure the following are installed and configured:

- Wezterm (stable or nightly build should work fine)

Verify your environment:

```
wezterm --version
```

Project Structure

```
.
├── lua/              # Lua source files for the configuration
├── bootstrap/        # Setup and maintenance scripts
├── LICENSE.md        # License information
└── README.md         # this file
```

## Getting started

**Configuration**

Configuration for wezterm is handled by Lua. Naturally, a Lua table is an appropriate data structure for managing the configuration values.

The configuration value table can be found in the `lua/utils/options.lua` file. This table is very loosely defined and has what is needed by the various options appliers that build the final configuration returned to wezterm.

The following known configuration values are supported:

- appearance: values that control the way the Wezterm GUI tabs and panes look.
- window: values that control the way the Wezterm GUI window looks.
- process_spawning: values that control the entries in the tab launcher menu.

**Installation**

The lua configuration for needs to be placed in an appropriate location as specified ![here](https://wezterm.org/config/files.html#configuration-files).

Alternatively the `bootstrap` directory contains scripts that are helpful in automating the installation and removal of this configuration.

**Troubleshooting**

Since this configuration has a central options table in `lua/utils/options.lua`, it can sometimes be difficult to see if the appropriate configuration options were set. This is particularly true since the options as interpreted by individual option types and applied as part of setting up the configuration.

Most issues can be can be diagnosed by using the debug overlay and inspecting the value returned by `window:effective_config()`. 
