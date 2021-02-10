#!/bin/bash
clear
database="/root/usuarios.db"
fun_multilogin() {
    (
        while read user; do
            resetpsw=$(head -1 /etc/SSHPlus/senha/$user)
            password='admin'
            [[ $(grep -wc "$user" $database) != '0' ]] && limit="$(grep -w $user $database | cut -d' ' -f2)" || limit='1'
            echo 'fun chamado uma vez'
            conssh="$(ps -u $user | grep sshd | wc -l)"
            [[ "$conssh" -gt "$limit" ]] && {
                pkill -u $user
                echo "$user:$password" | chpasswd
                sleep 15
                echo "$user:$resetpsw" | chpasswd
            }
            [[ -e /etc/openvpn/openvpn-status.log ]] && {
                ovp="$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | wc -l)"
                [[ "$ovp" -gt "$limit" ]] && {
                    pidokill=$(($limit - $ovp))
                    listpid=$(grep -E ,"$user", /etc/openvpn/openvpn-status.log | cut -d "," -f3 | head -n $pidokill)
                    while read ovpids; do
                        (
                            telnet localhost 7505 <<-EOF
								kill $ovpids
							EOF
                        ) &>/dev/null &
                    done <<<"$listpid"
                }
            }
        done <<<"$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)"
    ) &
}

while true; do
    echo 'verificando...'
    fun_multilogin >/dev/null 2>&1
    sleep 15s
done
