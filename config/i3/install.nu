#!/usr/bin/env nu
use std log



export def i3_config [] {
  log info "Including Sway config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [ sway wl-clipboard ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/i3" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
