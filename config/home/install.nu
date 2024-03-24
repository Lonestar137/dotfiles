#!/usr/bin/env nu

use std log


export def home_config [] {
  log info "Installing home config files."

  # ln -sf $"($env.FILE_PWD)/hyprland.conf" $"($INSTALL_LOCATION)/nf"

  let INSTALL_LOCATION = $"($env.HOME)/"

  let dependencies = [ ]
  let symlinks = [
    {source: $"($env.FILE_PWD)/config/home/.bash_aliases" , target: $INSTALL_LOCATION},
    {source: $"($env.FILE_PWD)/config/home/.bash_bashrc" , target: $INSTALL_LOCATION},
    {source: $"($env.FILE_PWD)/config/home/.profile" , target: $INSTALL_LOCATION},
  ]

  let model = {
    dependencies: $dependencies,
    symlinks: $symlinks,
  }

  return $model
}
