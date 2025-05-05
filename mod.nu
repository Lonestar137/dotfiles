
export use packages.nu
export use config/nushell/install.nu *
export use config/home/install.nu *
export use config/hypr/install.nu *
export use config/helix/install.nu *
export use config/kitty/install.nu *
export use config/rofi/install.nu *
export use config/waybar/install.nu *
export use config/wezterm/install.nu *
export use config/zellij/install.nu *
export use config/i3/install.nu *


# Put package names here for each distro, with the dependency and PackageManager as a composite key.
# By default, ARCH package names are used.
# TODO: Add limited support for Windows? i.e. choco
export const PACKAGE_DICTIONARY = {
  dunst: {
    pacman: dunst,
    apt: _
  },
  nushell: {
    pacman: nu,
    apt: _
  },
  helix: {
    pacman: helix-git,
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
  kitty: {
    pacman: kitty,
    apt: _
  }
  qt5ct: {
    pacman: qt5ct,
    apt: _
  }
  rofi: {
    pacman: rofi-lbonn-wayland,
    apt: _
  },
  sway: {
    pacman: sway,
    apt: _
  }
  obs: {
    pacman: obs-studio,
    apt: _
  }
  waybar: {
    pacman: waybar,
    apt: _
  }
  wezterm: {
    pacman: wezterm,
    apt: _
  },
  xdg-desktop-portal: {
    pacman: xdg-desktop-portal,
    apt: _
  },
  xdg-desktop-portal-wlr: {
    pacman: xdg-desktop-portal-wlr,
    apt: _
  },
  zellij: {
    pacman: zellij,
    apt: _
  }
}

