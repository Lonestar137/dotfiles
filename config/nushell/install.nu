#!/usr/bin/env nu
use std log



export def nushell_config [] {
  log info "Including nushell config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [ nushell ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/nushell" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
