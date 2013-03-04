# Shell functions for OS X

update_system () {
    update_brew
    update_node
    update_gems
}

update_brew () {
    echo "Update & upgrade brew"
    brew update ; brew upgrade
}

update_node () {
    echo "Updating node pacakges"
    npm -g update npm; npm -g update
}

update_gems () {
    echo "Updating gems"
    gem update ; gem update --system
}

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

