#!/usr/bin/python3
# This script was created by HaxGuru.

# Modules
import os, subprocess

# Functions
def inpt(type, msg):
  return type(input(msg))

def mkdir(path):
  if not os.path.exists(path):
    os.mkdir(path)

print("Welcome to the setup script!")
print("Please provide the following info about your android/ios device:")

# getting details
width = inpt(int, "Display Width: ")
height = inpt(int, "Display Height: ")
refresh_rate = inpt(int, "Refresh Rate: ")
print("CREATE A PASSWORD")
while True:
  pass = input("Enter a password that you can remember for your vnc: ")
  confirm_pass = input("Confirm password: ")
  if pass != confirm_pass:
    print("Passwords don't match!")
  else:
    break

mkdir('./temp')

os.system(f'cvt {width} {height} {refresh_rate} > temp/modeline.txt')
with open('./temp/modeline.txt') as x:
  modeline = x.read().split('Modeline')[1][1::]

# running commands
print("Creating folder 'vnc'..")
mkdir('~/.vnc')

# saving password
print("Saving your password...")
os.system(f"x11vnc -storepasswd {password} ~/.vnc/passwd")

# creating new mode for xrandr
print("Creating new display mode...")
os.system(f'xrandr --newmode {modeline}')
