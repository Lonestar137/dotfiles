#!/usr/bin/env nu
use std log



export def hypr_config [] {
  log info "Including hyprland config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = [ rofi-lbonn-wayland ]
  let dependencies = [hyprland-git hypridle hyprpaper hyprlock dunst qt5ct kitty wezterm hypridle wl-clipboard ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/hypr" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
