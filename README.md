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

## Roadmap

**Option coverage**

Configuration options listed in wezterm's documentation can be grouped into something like:

- window
    - typography
      - custom_block_glyphs
      - font
      - font_size
      - char_select_font
      - char_select_font_size
      - command_palette_font
      - command_palette_font_size
      - pane_select_font
      - font_dirs
      - font_locator
      - font_rules
      - font_shaper
      - harfbuzz_features
      - log_unknown_escape_sequences
      - strikethrough_position
      - treat_east_asian_ambiguous_width_as_wide
      - underline_position
      - underline_thickness
      - use_cap_height_to_scale_fallback_fonts
      - warn_about_missing_glyphs
    - theme
      - color_schemes
      - colors
      - char_select_bg_color
      - char_select_fg_color
      - command_palette_bg_color
      - command_palette_fg_color
      - force_reverse_video_cursor
      - foreground_text_hsb
      - reverse_video_cursor_min_contrast
    - cursor
      - cursor_blink_ease_in
      - cursor_blink_ease_out
      - cursor_blink_rate
      - cursor_thickness
      - default_cursor_style
    - frame
      - adjust_window_size_when_changing_font_size
      - background
      - enable_scroll_bar
      - enable_tab_bar
      - hide_tab_bar_if_only_one_tab
      - enable_wayland
      - integrated_title_button_alignment
      - integrated_title_button_color
      - integrated_title_button_style
      - integrated_title_buttons
      - kde_window_background_blur
      - macos_fullscreen_extend_behind_notch
      - macos_window_background_blur
      - min_scroll_bar_height
      - native_macos_fullscreen_mode
      - show_close_tab_button_in_tabs
      - show_new_tab_button_in_tab_bar
      - show_tab_index_in_tab_bar
      - show_tabs_in_tab_bar
      - status_update_interval
      - tab_and_split_indices_are_zero_based
      - tab_bar_at_bottom
      - tab_bar_style
      - tab_max_width
      - tiling_desktop_environments
      - use_fancy_tab_bar
      - use_resize_increments
      - wayland_window_background_blur
      - win32_acrylic_accent_color
      - win32_system_backdrop
      - window_background_gradient
      - window_background_image
      - window_background_image_hsb
      - window_background_opacity
      - window_decorations
      - window_frame
      - window_padding
    - content
      - allow_square_glyphs_to_overflow_width
      - alternate_buffer_wheel_scroll_speed
      - bold_brightens_ansi_colors
      - command_palette_line_height
      - command_palette_rows
      - hyperlink_rules
      - normalize_output_to_unicode_nfc
      - scrollback_lines
      - term
      - text_blink_ease_in
      - text_blink_ease_out
      - text_blink_rapid_ease_in
      - text_blink_rapid_ease_out
      - text_blink_rate
      - text_blink_rate_rapid
      - text_min_contrast_ratio
      - window_content_alignment
    - render
      - animation_fps
      - anti_alias_custom_block_glyphs
      - cell_width
      - cell_widths
      - display_pixel_geometry
      - dpi
      - font_rasterizer
      - freetype_interpreter_version
      - freetype_load_flags
      - freetype_load_target
      - freetype_pcf_long_family_names
      - freetype_render_target
      - front_end
      - ime_preedit_rendering
      - line_height
      - max_fps
      - prefer_egl
      - ui_key_cap_rendering
      - unicode_version
      - webgpu_force_fallback_adapter
      - webgpu_power_preference
      - webgpu_preferred_adapter
    - alert
      - audible_bell
      - notification_handling
      - visual_bell
    - quit
      - clean_exit_codes
      - exit_behavior
      - exit_behavior_messaging
      - quit_when_all_windows_are_closed
      - skip_close_confirmation_for_processes_named
      - switch_to_last_active_tab_when_closing_tab
      - window_close_confirmation
- input
    - handling
      - allow_win32_input_mode
      - bypass_mouse_reporting_modifiers
      - canonicalize_pasted_newlines
      - debug_key_events
      - detect_password_input
      - disable_default_mouse_bindings
      - disable_default_quick_select_patterns
      - enable_csi_u_key_encoding
      - enable_kitty_keyboard      
      - hide_mouse_cursor_when_typing
      - macos_forward_to_ime_modifier_mask
      - mouse_wheel_scrolls_tabs
      - pane_focus_follows_mouse
      - quote_dropped_files
      - scroll_to_bottom_on_input
      - swallow_mouse_click_on_pane_focus
      - swallow_mouse_click_on_window_focus
      - unzoom_on_switch_pane
      - use_ime
      - xim_im_name
    - keybinds
      - key_map_preference
      - key_tables
      - swap_backspace_and_delete
      - treat_left_ctrlalt_as_altgr
    - select
      - quick_select_alphabet
      - quick_select_patterns
      - quick_select_remove_styling
      - selection_word_boundary
- session
    - gui
      - check_for_updates
      - automatically_reload_config
      - default_cwd
      - default_domain
      - default_gui_startup_args
      - default_prog
      - default_ssh_auth_sock
      - default_workspace
      - initial_cols
      - initial_rows
      - prefer_to_spawn_tabs
      - show_update_window
    - mux
      - daemon_options
      - default_mux_server_domain
      - mux_enable_ssh_agent
      - mux_env_remove
      - serial_ports
      - ssh_backend
      - ssh_domains
      - tls_clients
      - tls_servers
      - unix_domains
      - wsl_domains
    - launchmenu
      - launch_menu
      - launcher_alphabet
      - set_environment_variables
      - ulimit_nofile
      - ulimit_nproc
