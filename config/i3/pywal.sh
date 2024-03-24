#!/bin/sh

wallpaper_directory="/home/jonesgc/Pictures/Wallpapers"
random_wallpaper=$(ls "${wallpaper_directory}" | shuf -n 1)

wal -i "${wallpaper_directory}/${random_wallpaper}"
