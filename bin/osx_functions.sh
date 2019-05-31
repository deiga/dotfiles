# Shell functions for OS X

update_hosts () {
    curl http://someonewhocares.org/hosts/hosts | sudo tee /etc/hosts.whocare > /dev/null
}

current_wallpaper() {
    defaults read com.apple.desktop Background |grep LastName | awk '{print $3}'| sed -e 's/;//g' | sed -e 's/"//g' | uniq
}

