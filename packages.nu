
# Package groups


export def extra_packages [] {

  let wayland_obs = [ obs xdg-desktop-portal-wlr qt5ct pipewire ]
  # NOTE: Reboot after.

  let other_package = []


  let packages = ($wayland_obs ++ $other_package)
  return $packages
}
