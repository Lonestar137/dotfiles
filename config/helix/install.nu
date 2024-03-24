#!/usr/bin/env nu
use std log



export def helix_config [] {
  log info "Including hyprland config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [ helix ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/helix" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
