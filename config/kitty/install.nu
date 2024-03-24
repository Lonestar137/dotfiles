#!/usr/bin/env nu
use std log



export def kitty_config [] {
  log info "Including kitty config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [kitty]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/kitty" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
