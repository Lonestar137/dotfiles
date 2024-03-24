#!/usr/bin/env nu

# NOTE: This script must be run from the root of the dotfiles repo. (Nushell limitation)
use std log
use ./ *


def main [package_manager: string = "pacman"] {
  log info $"Using package manager: (ansi green)($package_manager)"

  log info "Cloning submodules. . ."
  git submodule update --init --recursive

  # Configs to include in the build.
  let include = [
    (kitty_config),
    (home_config),
    (hypr_config),
    (helix_config),
    (nushell_config),
    (rofi_config),
    (waybar_config),
    (wezterm_config),
    (zellij_config),
    (i3_config),
  ]
  let source_dependencies = ($include.source_dependencies | flatten | uniq | sort)
  let dependencies = ($include.dependencies | flatten | uniq | sort)
  let symlinks = ($include.symlinks | flatten | uniq | sort)

  log info "Generating install script. . ."
  let source_packages = $source_dependencies | str join " "
  match $package_manager {
    'pacman' => {
      echo $"(ansi green)"

      let packages = $dependencies | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      $symlinks | each { echo $"ln -sf ($in.source)    ($in.target)"}

      echo "\n"
      echo $"sudo pacman -Syu ($packages)"
      echo "\n"
      echo $"sudo paru -Syu ($source_packages)"
    },
    'apt' => {
      echo $"(ansi yellow)"
      echo $"Source packges that need to be built manually: ($source_packages)"
      echo $"(ansi green)"

      let packages = $dependencies | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      $symlinks | each { echo $"ln -sf ($in.source)    ($in.target)"}

      echo "\n"
      echo $"sudo apt install ($packages)"
    },
    _ => {echo $"Package manager (ansi red)($package_manager)(ansi reset) not supported."},
  }

  echo "\n\n"
}

# wezterm, zellij, helix, rofi
