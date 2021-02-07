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

abrirptsks() {
    sleep 1
    screen -dmS proxy python /etc/SSHPlus/proxy.py $checkport
    sleep 1
}

checkport=$1
portas=$(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)
if [[ $portas != *"$checkport"* ]]; then
    echo "True $checkport is missing"
    fun_bar 'abrirptsks'
    echo ""
    echo -e "\033[1;32mPROXY SOCKS ATIVADO COM SUCESSO\033[1;33m"
    sleep 2
else
    echo "False the $checkport port is ok"
fi
