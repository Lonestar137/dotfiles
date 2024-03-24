#!/usr/bin/env nu
use std log



export def hypr_config [] {
  log info "Installing hyprland."

  # ln -sf $"($env.FILE_PWD)/hyprland.conf" $"($INSTALL_LOCATION)/nf"

  let INSTALL_LOCATION = $"($env.HOME)/.config/hyprland/"

  let dependencies = [hyprland-git hypridle hyprpaper hyprlock dunst qt5ct wezterm rofi hypridle]
  let symlinks = [
    # {source: $"($env.FILE_PWD)/hyprland.conf" , target: $INSTALL_LOCATION},
    # {source: $"($env.FILE_PWD)/hypridle.conf" , target: $INSTALL_LOCATION},
    # {source: $"($env.FILE_PWD)/hyprlock.conf" , target: $INSTALL_LOCATION},
     {source: $"($env.FILE_PWD)/config/hypr" , target: $INSTALL_LOCATION},
  ]

  let model = {
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
