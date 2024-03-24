#!/usr/bin/env nu
use std log



export def wezterm_config [] {
  log info "Including wezterm config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [ wezterm ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/wezterm" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
