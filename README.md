# android-as-monitor-linux  
### This script will help you use your android device as a second monitor.  
This script creates a vnc server with the information of your android device's resolution. You can download any VNC app on android and to connect to your server and use it as a second monitor. You need to enable USB-Debugging for it to work. Please enable USB-Tethering for faster performance.  
  
# Dependecies  
### Please install the following depencencies before running the program 👇  
Ubuntu- `sudo apt update; sudo apt install x11vnc adb notify-send`  
Manjaro- `sudo pacman -S x11vnc adb`  
#### Please visit these links for other distros-  
x11vnc- https://pkgs.org/search/?q=x11vnc  
adb- https://pkgs.org/search/?q=adb&on=files  
notify-send- https://pkgs.org/search/?q=notify-send  

# Download
Clone the repository in your Downloads folder:  
`git clone https://github.com/Prayag2/android-as-monitor-linux.git ~/Downloads/android-as-monitor-linux`  
  
# Run the script  
`sudo chmod +x ./setup.sh; ./setup.sh`    

# Uninstall
`sudo chmod +x ./uninstall.sh; ./uninstall.sh`

# Usage
This script will create two `.desktop` files named "startvnc.desktop" and "closevnc.desktop" in `~/.local/share/applications`.  
Steps:
- Connect your Android device and enable USB-Debugging (enable usb-tethering for faster performance).
- Run "Start VNC" from your application menu to start the vnc.
- Enter details in the VNC app in your android such as your ip address, port and password (details will be provided by a notification).
- Zoom in so that you are only able to see the second desktop (the black screen).
- You can move windows to your secondary monitor (android) with the help of your mouse.
- Enjoy!

Thanks for using this script! I know the code is quite bad because a lot of lines are repeated and I know I could've done this with bash instead of python but I don't know much about bash and my exams are near so I used Python because I already knew a lot about it! Thanks again!
Please visit my YouTube channel: http://bit.ly/hxyoutube
