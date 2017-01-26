# This script will install hexchat and or otr automatically on gnu debian linux based distros like mint & ubuntu
#!/bin/sh

echo "This script will install/update hexchat and or otr automatically"
echo "It is made for gnu debian linux based distros like mint & ubuntu"
echo "It is meant to run as regular user with sudo permitions"
echo "If you are running debian based without sudo this script will fail"

        echo
        read -r -p "Are you sure ? [y/N]" response
        case $response in
        [yY][eE][sS]|[yY])

	# Software and dependences needed:
        sudo apt-get install hexchat gcc make pkg-config libglib2.0-dev git automake autoconf-archive libtool glibc-source libcrypt-gcrypt-perl libotr5-dev

	# Check for old and or outdated hexchat-otr files:
        if [ hexchat-otr ]
        then
        rm -rf hexchat-otr
        else
        echo "hexchat-otr not found. Downloading..."
        fi

	# Download new/update hexchat-otr sources:
	git clone https://github.com/TingPing/hexchat-otr
        cd hexchat-otr
	# compile the sources:
	./autogen.sh ; make -s
	sudo make install

# Copy server list to hexchat-otr:
cat <<EOT >> ~/.config/hexchat/servlist.conf
N=WirelessPT
E=UTF-8 (Unicode)
F=127
D=1
S=irc.wirelesspt.net/6697
J=#wirelesspt
J=#nixbits

N=WirelessPT Tor
E=UTF-8 (Unicode)
F=55
D=0
S=2rfrzlrbwvbvlxpo.onion/6667
J=#wirelesspt
J=#nixbits
EOT

#echo cmsv >> ~/.config/hexchat/notify.conf

        echo
        read -r -p "Start hexchat? [y/N]" response
        case $response in
        [yY][eE][sS]|[yY])

	echo "Starting hexchat...";
	DISPLAY=:0.0 hexchat &
  	;;
        *)
	;;
        esac
echo
echo "To start OTR open a chat windows with someone usin OTR and type /otr start";
echo "To end conversation type /otr finish";
echo "Check this out https://wirelesspt.net/wiki/Hexchat"
        ;;
        *)
        echo
        echo "Really ? Check this out: https://en.wikipedia.org/wiki/Off-the-Record_Messaging"
        echo
        ;;
        esac

