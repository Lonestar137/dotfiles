
export use config/home/install.nu *
export use config/hypr/install.nu *



# Put package names here for each distro, with the dependency and PackageManager as a composite key.
# By default, ARCH package names are used.
# TODO: Add limited support for Windows? i.e. choco
export const PACKAGE_DICTIONARY = {
    dunst: {
      pacman: dunst,
      apt: _
    },
    hyprland-git: {
      pacman: hyprland-git,
      apt: _
    },
    hyprlock: {
      pacman: hyprlock,
      apt: _
    },
    hyprpaper: {
      pacman: hyprpaper,
      apt: _
    },
    hypridle: {
      pacman: hypridle,
      apt: _
    },
    qt5ct: {
      pacman: qt5ct,
      apt: _
    }
    rofi: {
      pacman: rofi,
      apt: _
    },
    wezterm: {
      pacman: wezterm,
      apt: _
    }
  }

