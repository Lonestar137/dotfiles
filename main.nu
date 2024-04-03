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
    (home_config),
    (kitty_config),
    (hypr_config),
    (helix_config),
    (nushell_config),
    (rofi_config),
    (waybar_config),
    (wezterm_config),
    (zellij_config),
    (i3_config),
  ]

  let extra_packages = (extra_packages)
  let source_dependencies = ($include.source_dependencies | flatten | uniq | sort)
  let dependencies = ($include.dependencies | flatten | uniq | sort)
  let symlinks = ($include.symlinks | flatten | uniq | sort)

  log info "Generating install script. . ."
  let source_packages = $source_dependencies | str join " "
  match $package_manager {
    'pacman' => {
      echo $"(ansi blue)"

      # TODO: move this stuff out into a function for DRY.
      let config_packages = $dependencies | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      let extras = $extra_packages | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      $symlinks | each { echo $"ln -sf ($in.source)    ($in.target)"}

      echo "\n"
      echo $"sudo pacman -Syu ($config_packages)"
      echo $"sudo pacman -Syu ($extras)"
      echo "\n"
      echo $"sudo paru -Syu ($source_packages)"
    },
    'apt' => {
      echo $"(ansi yellow)"
      echo $"Source packges that need to be built manually: ($source_packages)"
      echo $"(ansi green)"

      let config_packages = $dependencies | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      let extras = $extra_packages | each { |dep|
        $PACKAGE_DICTIONARY | get $dep
      } | get $package_manager | str join " "

      $symlinks | each { echo $"ln -sf ($in.source)    ($in.target)"}

      echo "\n"
      echo $"sudo apt install ($config_packages)"
      echo $"sudo apt install ($extras)"
    },
    _ => {echo $"Package manager (ansi red)($package_manager)(ansi reset) not supported."},
  }

  echo "\n\n"
}

# wezterm, zellij, helix, rofi
