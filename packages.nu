
# Package groups


export def extra_packages [] {

  let wayland_obs = [ obs xdg-desktop-portal-wlr qt5ct pipewire]
  let podman_xfs = [ fuse-overlayfs ]
  # NOTE: Reboot after.

  let other_package = []


  let packages = ($wayland_obs ++ $podman_xfs ++ $other_package)
  return $packages
}
