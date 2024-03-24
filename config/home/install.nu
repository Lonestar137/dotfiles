#!/usr/bin/env nu

use std log


export def home_config [] {
  log info "Including home config files."

  let INSTALL_LOCATION = $"($env.HOME)/"

  let source_dependencies = []
  let dependencies = [ ]
  let symlinks = [
    {source: $"($env.FILE_PWD)/config/home/.bash_aliases" , target: $INSTALL_LOCATION},
    {source: $"($env.FILE_PWD)/config/home/.bash_bashrc" , target: $INSTALL_LOCATION},
    {source: $"($env.FILE_PWD)/config/home/.profile" , target: $INSTALL_LOCATION},
  ]

  let model = {
    source_dependencies: $source_dependencies,
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
