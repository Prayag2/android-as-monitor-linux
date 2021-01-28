#!/bin/bash
echo 'Do you really want to uninstall the script? (y/n): '
read x
if [ $x = 'y' ]; then
  echo 'Uninstalling script...'
  rm -r ~/.haxguru > /dev/null 2>&1
  rm ~/.local/share/applications/startvnc.Desktop > /dev/null 2>&1
  rm ~/.local/share/applications/closevnc.desktop > /dev/null 2>&1
  rm -r ~/.vnc > /dev/null 2>&1
  echo 'Uninstalled successfully!'
else
  echo 'Uninstall was aborted.'
fi
