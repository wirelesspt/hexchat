
# Changelog:

# Thu 04 Oct 2019 12:49:06 PM EDT version 3.1
# - Script configuration corrections

# Thu 03 Oct 2019 07:47:10 AM EDT - version 3.0
# - Hardened hexchat auto configuration for improved setup


### Copy server list to hexchat-otr:
cat <<EOT >> ~/.config/hexchat/servlist.conf
N=WirelessPT
E=UTF-8 (Unicode)
F=127
D=1
S=irc.wirelesspt.net/6697
J=#wirelesspt
J=#nixbits

N=WirelessPT Tor Hidden Server
E=UTF-8 (Unicode)
F=55
D=0
S=ycvrxhprsgkl3hvdymtogq4ukrpa3qwzbg3yfnbuipomviu2sscwyaid.onion/6697
J=#wirelesspt
J=#nixbits
EOT

### Add devs to notify list
echo cmsv >> ~/.config/hexchat/notify.conf

# Anonimize hexchat
echo "Would you like to anonimize hexchat (as much as possible) to" 
echo "prevent it to give information about itself to other parties"
echo "Please say Yes. It is highly recomended!"

	echo
	read -r -p "Continue? [Y/n] " input
	case $input in
	[yY][eE][sS]|[yY])

# /set
sed -i 's/away_show_once = 1/away_show_once = 0 /g'		~/.config/hexchat/hexchat.conf
sed -i 's/dcc_ip = /dcc_ip =/g'					~/.config/hexchat/hexchat.conf
sed -i 's/dcc_ip_from_server = 1/dcc_ip_from_server = 0/g'	~/.config/hexchat/hexchat.conf
sed -i 's/identd_port = 1/identd_port = 0/g'			~/.config/hexchat/hexchat.conf
sed -i 's/irc_hide_version = 0/irc_hide_version = 1/g'		~/.config/hexchat/hexchat.conf
sed -i 's/irc_hidehost = 0/irc_hidehost = 1/g'			~/.config/hexchat/hexchat.conf
sed -i 's/irc_invisible = 0/irc_invisible = 1/g'		~/.config/hexchat/hexchat.conf
sed -i 's/irc_part_reason = Leaving/irc_part_reason = /g'	~/.config/hexchat/hexchat.conf
sed -i 's/irc_quit_reason = Leaving/irc_quit_reason = /g'	~/.config/hexchat/hexchat.conf
sed -i 's/irc_real_name = realname/irc_real_name = -/g'		~/.config/hexchat/hexchat.conf

echo 'mask = *!*@*'	>>					~/.config/hexchat/ignore.conf
echo 'type = 8'		>>					~/.config/hexchat/ignore.conf  

	;;
	[nN][oO]|[nN])
	;; 
	*)
	;;
	esac

# Amnesia keeps no records. No logs
echo
echo "Amnesia keeps no records. Avoid logging things."
echo "Please say Yes. It is highly recomended!"

	echo
        read -r -p "Continue? [Y/n] " input
        case $input in
        [yY][eE][sS]|[yY])

# /set
sed -i 's/irc_logging = 1/irc_logging = 0/g'			~/.config/hexchat/hexchat.conf
sed -i 's/stamp_log = 1/stamp_log = 0/g'			~/.config/hexchat/hexchat.conf
sed -i 's/stamp_text = 1/stamp_text = 0/g'			~/.config/hexchat/hexchat.conf
sed -i 's/url_logging = 1/url_logging = 0/g'			~/.config/hexchat/hexchat.conf
sed -i 's/url_grabber = 1/url_grabber = 0/g'			~/.config/hexchat/hexchat.conf

        ;;
        [nN][oO]|[nN])
        ;;
        *)
        ;;
        esac

# Optimize hexchat
echo
echo "The follwoing will optimize hexchat look and feel"
echo "Say Yes. You can always change things later"

	echo
        read -r -p "Continue? [Y/n] " input
        case $input in
        [yY][eE][sS]|[yY])

# /set
sed -i 's/gui_chanlist_minusers = 5/gui_chanlist_minusers = 1/g'   ~/.config/hexchat/hexchat.conf
sed -i 's/gui_input_spell = 0/gui_input_spell = 1/g'		   ~/.config/hexchat/hexchat.conf
sed -i 's/irc_servernotice = 0/irc_servernotice = 1/g'		   ~/.config/hexchat/hexchat.conf
sed -i 's/irc_skip_motd = 0/irc_skip_motd = 1/g'		   ~/.config/hexchat/hexchat.conf
sed -i 's/irc_wallops = 0/irc_wallops = 1/g'			   ~/.config/hexchat/hexchat.conf
sed -i 's/irc_whois_front = 0/irc_whois_front = 1/g'		   ~/.config/hexchat/hexchat.conf
sed -i 's/notify_whois_online = 0/notify_whois_online = 1/g'	   ~/.config/hexchat/hexchat.conf
sed -i 's/text_stripcolor_msg = 0/text_stripcolor_msg = 1/g'	   ~/.config/hexchat/hexchat.conf
sed -i 's/text_stripcolor_replay = 0/text_stripcolor_replay = 1/g' ~/.config/hexchat/hexchat.conf
sed -i 's/text_stripcolor_topic = 0/text_stripcolor_topic = 1/g'   ~/.config/hexchat/hexchat.conf

        ;;
        [nN][oO]|[nN])
        ;;
        *)
        ;;
        esac

# Use with Tor
echo
echo "Would you like to use hexchat with Tor? This is recomended"
echo "It requires to have tor installed. You can say Yes now and install Tor right after"

	echo
        read -r -p "Continue? [Y/n] " input
        case $input in
        [yY][eE][sS]|[yY])

# /set
sed -i 's/net_proxy_port = 0/net_proxy_port = 9050/g'		~/.config/hexchat/hexchat.conf
sed -i 's/net_proxy_host = /net_proxy_host = 127.0.0.1/g'	~/.config/hexchat/hexchat.conf
sed -i 's/net_proxy_type = 0/net_proxy_type = 3/g'		~/.config/hexchat/hexchat.conf
sed -i 's/net_proxy_use = 0/net_proxy_use = 1/g'		~/.config/hexchat/hexchat.conf

        ;;
        [nN][oO]|[nN])
        ;;
        *)
        ;;
        esac

