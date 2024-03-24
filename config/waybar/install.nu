#!/usr/bin/env nu
use std log



export def waybar_config [] {
  log info "Including Waybar config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [ waybar ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/waybar" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
