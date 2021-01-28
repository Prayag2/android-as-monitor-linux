#!/usr/bin/python3
# This script will let you use your android device as a second monitor by creating a vnc server! It is user friendly and easy to use! Please report if you face any bugs/issues!
# This script was created by HaxGuru.
# I know the code is bad and a lot of lines are repeated but it is just a one time script and I had very less time because of my exams.. Thanks for using this script :)
# YouTube - http://bit.ly/hxyoutube

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
while True:
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
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    confirm = input("Please confirm your answers by entering 'y' or 'n': ")
    if confirm == 'y':
        break
    else:
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        continue

modeline = os.popen(f'cvt {width} {height} {refresh_rate} | grep "Modeline"').read().split('Modeline')[1][1::]
resolution = modeline.split('"')[1]
current_output = os.popen("xrandr --listmonitors | awk '{print $4}'").read().split()[0]

# running commands
print("Creating folder 'vnc'..")
mkdir(f'{userpath}/.vnc')

# saving password
print("Saving your password...")
os.system(f"x11vnc -storepasswd {password} ~/.vnc/passwd")

try:
    output = os.popen("xrandr | grep 'disconnected' | awk '{print $1}'").read().split()[0]
except:
    dec("Something went wrong :(")

# startvnc commands
positions = ['--right-of', '--left-of', '--below', '--top']
scriptcommands = [
"#!/bin/bash",
f'xrandr --newmode {modeline}',
f"xrandr --addmode {output} {resolution}",
f"xrandr --output {output} --mode {resolution} {positions[position]} {current_output}",
"adb reverse tcp:5900 tcp:5900",
"x11vnc -rfbauth ~/.vnc/passwd",
"echo *************************************************",
"echo Please run the program \"Close VNC\" to close the vnc!",
"echo *************************************************"
]

# creating startvnc.sh
dec("Creating the script...")
mkdir(f"{userpath}/.haxguru")
with open(f"{userpath}/.haxguru/startvnc.sh", 'w') as x:
  x.write('\n'.join(scriptcommands))

closevnc_commands = [
'#!/bin/bash',
'killall x11vnc',
f'xrandr --output {output} --off'
]

with open(f"{userpath}/.haxguru/closevnc.sh", 'w') as x:
    x.write('\n'.join(closevnc_commands))

# deleting variables from memory
del positions, modeline, output, resolution, current_output, position, closevnc_commands

# .desktop data
data = [
'[Desktop Entry]',
'Encoding=UTF-8',
'Version=1.0',
'Type=Application',
'Terminal=true',
f'Exec={userpath}/.haxguru/startvnc.sh',
'Name=Start VNC',
'Icon=cs-screen'
]

# creating .desktop file
with open(f'{userpath}/.local/share/applications/startvnc.desktop', 'w') as x:
    x.write('\n'.join(data))

# creating .desktop file for closevnc.sh
data[5] = f'Exec={userpath}/.haxguru/closevnc.sh'
data[6] = "Name=Close VNC"
data[7] = "Icon=cs-screensaver"

with open(f'{userpath}/.local/share/applications/closevnc.desktop', 'w') as x:
    x.write('\n'.join(data))

# making startvnc.sh, startvnc.desktop, closevnc.sh and closevnc.desktop executable
print("Please enter your root password to make the script executable...")
os.system(f'sudo chmod +x {userpath}/.haxguru/startvnc.sh {userpath}/.haxguru/closevnc.sh {userpath}/.local/share/applications/startvnc.desktop {userpath}/.local/share/applications/closevnc.desktop')

# Success Message
dec("SUCCESS! You can now run the program named \"Start VNC\" to start the vnc server! Please note that you have to connect your android device and enable usb-debugging before continuing... Make sure that both the devices are connected to the same network! Please enable USB-Tethering for faster performance... You can stop the vnc by running the program \"Close VNC\"! Please check out your YouTube channel- http://bit.ly/hxyoutube/")
