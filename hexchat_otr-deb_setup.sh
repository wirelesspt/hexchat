### Revised: Thu Jan 26 22:14:35 EST 2017 - Version 2
### Author: Miguel Vieira
### This script will automatically install and or update hexchat and otr on gnu debian linux based distros like mint & ubuntu.
### Turns insecure private messages automatically into off the record encrypted conversations onde a query is started.

#!/bin/sh

echo "This script will install/update hexchat and or otr automatically"
echo "It is made for gnu debian linux based distros like mint & ubuntu"
echo "It is meant to run as regular user with sudo permissions"
echo "If you are running debian based without sudo this script will fail"

        echo
        read -r -p "Are you sure ? [y/N]" response
        case $response in
        [yY][eE][sS]|[yY])

	# Software and dependences needed:
	sudo apt-update
        sudo apt-get -y install hexchat gcc make pkg-config libglib2.0-dev git automake autoconf-archive libtool glibc-source libcrypt-gcrypt-perl libotr5-dev

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

### Copy server list to hexchat-otr:
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

### Add devs to notify list
echo cmsv >> ~/.config/hexchat/notify.conf

### Prepare addons/otr_autostart.lua
mkdir ~/.config/hexchat/addons

cat <<EOT >> ~/.config/hexchat/addons/otr_autostart.lua
-- Auto starts OTR query
hexchat.register('OTRPM', '2', 'Automatically start otr upon /query nick')

hexchat.hook_print('Open Context', function (args)
        -- We only want queries
        if hexchat.props['type'] ~= 3 then
                return
        end

        -- Ignore empty tabs, znc queries, and scripting consoles
        if not hexchat.get_info('channel'):match('^[%*%(>]') then
                hexchat.command('chanopt -quiet /otr start')
        end
end)
EOT

### Ready to use Hexchat
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

