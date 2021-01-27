#!/usr/bin/python3
# This script was created by HaxGuru.

# Modules
import os, subprocess

# Global Variables
userpath = os.path.expanduser('~')

# Functions
def inpt(type, msg):
  return type(input(msg))

def dec(text):
    deco = "~"*(len(text) if len(text) < 60 else 60)
    print(deco)
    print(text)
    print(deco)


def mkdir(path):
  if not os.path.exists(path):
    os.mkdir(path)

print("This script was made by")
print('''
 _   _             ____
| | | | __ ___  __/ ___|_   _ _ __ _   _
| |_| |/ _` \ \/ | |  _| | | | '__| | | |
|  _  | (_| |>  <| |_| | |_| | |  | |_| |
|_| |_|\__,_/_/\_\\____|\__,_|_|   \__,_|

''')
dec("Please provide the following info about your android device:")

# getting details
width = inpt(int, "Display Width: ")
height = inpt(int, "Display Height: ")
refresh_rate = inpt(int, "Refresh Rate: ")
position = inpt(int, "Choose the position of your new monitor (0 for right, 1 for left, 2 for bottom, 3 for top): ")
while True:
  password = input("Enter a password that you can remember for your vnc: ")
  confirm_pass = input("Confirm password: ")
  if password != confirm_pass:
    dec("ERROR: Passwords don't match!")
  else:
    break

modeline = os.popen(f'cvt {width} {height} {refresh_rate}').read().split('Modeline')[1][1::]
resolution = modeline.split('"')[1]
current_output = os.popen("xrandr --listmonitors").read().split(' ')[-1].splitlines()[0]

# running commands
print("Creating folder 'vnc'..")
mkdir(f'{userpath}/.vnc')

# saving password
print("Saving your password...")
os.system(f"x11vnc -storepasswd {password} ~/.vnc/passwd")

# creating new mode for xrandr
print("Creating new display mode...")

# os.system(f'xrandr --newmode {modeline}')
try:
    output = os.popen('xrandr').read().partition("disconnected")[0].splitlines()[1]
except:
    dec("It seems like your PC doesn't have a spare display port :/\n Sorry but it won't work on your PC :(")
else:
    print("Creating the new script..")

# startvnc commands
positions = ['--right-of', '--left-of', '--below', '--top']
scriptcommands = [f"xrandr --addmode {output} {resolution}", f"xrandr --output {output} --mode {resolution} {positions[position]} {current_output}", "adb reverse tcp:5900 tcp:5900", "x11vnc -rfbauth ~/.vnc/passwd", ]

joined = '\n'.join(scriptcommands)

# creating startvnc.sh
mkdir(f"{userpath}/.haxguru")
with open(f"{userpath}/.haxguru/startvnc.sh", 'w') as x:
  x.write(f"#!/bin/bash\n{joined}")

# deleting variables from memory
del positions

# .desktop data
data = ['[Desktop Entry]', 'Encoding=UTF-8', 'Version=1.0', 'Type=Application', 'Terminal=true', f'Exec={userpath}/.haxguru/startvnc.sh > /dev/null 2>&1 &', 'Name=Start VNC', 'Icon=cs-screen']

# creating .desktop file
with open(f'{userpath}/.local/share/applications/startvnc.desktop', 'w') as x:
    x.write('\n'.join(data))

dec("SUCCESS! You can now run the program named \"Start VNC\" to start the vnc server! Please note that you have to connect your android device and enable usb-debugging before continuing... Make sure that both the devices are connected to the same network! Please enable USB-Tethering for faster performance...")
