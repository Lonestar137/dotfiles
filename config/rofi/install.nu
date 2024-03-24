#!/usr/bin/env nu
use std log



export def rofi_config [] {
  log info "Including rofi config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = [ rofi-lbonn-wayland ]
  let dependencies = []
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/rofi" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
