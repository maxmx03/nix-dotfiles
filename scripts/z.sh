#!/usr/bin/env bash

function z() {
  local locations=(
  "$HOME/dotfiles"
  "$HOME/.config"
  "$HOME"
  "/"
   )

  for location_to_find in "${locations[@]}"; do
    pushd "${location_to_find}"
    local location=$(fd -p -g -H -I --maxdepth 2 "**/$1" | head -1)

    if [ -z $location ]; then
      echo "Could not find $1"
      popd
    else
      cd $location
      clear
      break
    fi
  done
}
