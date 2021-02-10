#!/bin/bash
fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        [[ ! -d /etc/SSHPlus ]] && rm -rf /bin/menu
        ${comando[0]} >/dev/null 2>&1
        ${comando[1]} >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[1;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

fun_socksoff() {
    for pidproxy in $(screen -ls | grep ".proxy" | awk {'print $1'}); do
        screen -r -S "$pidproxy" -X quit
    done
    [[ $(grep -wc "proxy.py" /etc/autostart) != '0' ]] && {
        sed -i '/proxy.py/d' /etc/autostart
    }
    sleep 1
    screen -wipe >/dev/null
}
fun_bar 'fun_socksoff'
sleep 3
