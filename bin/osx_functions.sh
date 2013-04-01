# Shell functions for OS X

update_hosts () {
    curl http://someonewhocares.org/hosts/hosts | sudo tee /etc/hosts.whocare > /dev/null
}

parents_wifi () {
    /usr/sbin/networksetup -setairportpower Wi-Fi off
    sleep 1
    /usr/sbin/networksetup -setairportpower Wi-Fi on
    sleep 3
    /usr/sbin/networksetup -setairportnetwork Wi-Fi JASWIFI detlef23
}

