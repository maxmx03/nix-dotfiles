export NIXPKGS_ALLOW_UNFREE=1

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export GTK_THEME="WhiteSur-Dark"
  export XDG_SESSION_DESKTOP="Hyprland"
  export XDG_SESSION_TYPE="wayland"
  export XDG_CURRENT_DESKTOP="Hyprland"

  exec Hyprland
fi
