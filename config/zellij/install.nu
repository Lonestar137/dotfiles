#!/usr/bin/env nu
use std log



export def zellij_config [] {
  log info "Including zellij config files."

  let INSTALL_LOCATION = $"($env.HOME)/.config/"

  let source_dependencies = []
  let dependencies = [ zellij ]
  let symlinks = [
     {source: $"($env.FILE_PWD)/config/zellij" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
