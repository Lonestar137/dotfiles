#!/usr/bin/env nu

# NOTE: This script must be run from the root of the dotfiles repo. (Nushell limitation)
use std log
use ./ *


def main [package_manager: string = "pacman"] {
  log info $"Using package manager: (ansi green)($package_manager)"
  # Configs to include in the build.
  let include = [
    (home_config),
    (hypr_config)
  ]
  #TODO let source_dependencies = ($include.source_dependencies | flatten | uniq | sort)
  let dependencies = ($include.dependencies | flatten | uniq | sort)
  let symlinks = ($include.symlinks | flatten | uniq | sort)
  # echo $dependencies
  # echo $symlinks

  echo "Generating install script. . . \n\n"
  match $package_manager {
    'pacman' => {
      echo $"(ansi green)"
      let packages = $dependencies | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      $symlinks | each { echo $"ln -sf ($in.source)    ($in.target)"}

      # echo $"Packages to be installed: (ansi green)($packages)(ansi reset)"
      echo $"sudo pacman -Syu ($packages)"
    },
    'apt' => {
      echo $"(ansi green)"
      let packages = $dependencies | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      # echo $"Packages to be installed: (ansi green)($packages)(ansi reset)"
      echo $"sudo apt install ($packages)"
    },
    _ => {echo $"Package manager (ansi red)($package_manager)(ansi reset) not supported."},
  }


  

  echo "\n\n"
  # echo $PACKAGE_DICTIONARY
}
