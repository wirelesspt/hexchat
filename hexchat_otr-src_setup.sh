# Revised: Thu 03 Oct 2019 07:47:10 AM EDT - version 3.0
# Changelog:
# - Update otr sources build code
# - Update tor irc address and port
# - Added hardened hexchat auto configuration for improved setup

# Revised: Thu Jan 26 22:14:35 EST 2017 - Version 2.1
# Changelog:
# - Initial development

###

### Author: Miguel Vieira
### This script will automatically install and or update hexchat and otr on gnu debian linux based distros like debian, mint, ubuntu, kali.
### Turns insecure private messages automatically into off the record encrypted conversations onde a query is started.

#!/bin/sh

echo "This script will install/update hexchat and or otr automatically"
echo "It is made for gnu gentoo linux based distros like gentoo, pentoo, sabayon, funtoo"
echo "It is meant to run as regular user with su access password"

        echo
        read -r -p "Are you sure ? [y/N]" response
        case $response in
        [yY][eE][sS]|[yY])

	# Software and dependences needed:
	echo net-irc/hexchat ~amd64 >> /etc/portage/package.keywords/net-irc
	echo net-irc/hexchat gtk libproxy plugin-checksum plugin-sysinfo plugins plugin-fishlim spell ssl >> /etc/portage/package.use/hexchat
	emerge hexchat libotr

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
	meson builddir
	ninja -C builddir
	echo
	echo "Type your root password to continue the install"
	su -c 'ninja -C builddir install'

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
	echo "Starting hexchat...";
	DISPLAY=:0.0 hexchat &

echo
echo "To start OTR open a chat windows with someone usin OTR and type /otr start";
echo "To end conversation type /otr finish";
echo "https://wirelesspt.net/wiki/Hexchat"
echo "https://en.wikipedia.org/wiki/Off-the-Record_Messaging"
echo

echo "If you want a hardened, more secure and private hexchat configuration"
echo "copy and paste the following 2 lines on your terminal but only after"
echo "having executed hexchat at least once"

echo
echo "wget https://raw.githubusercontent.com/wirelesspt/hexchat/master/hexchat_config.sh"
echo "chmod +x hexchat_config.sh ; ./hexchat_config.sh"
echo
