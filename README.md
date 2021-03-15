ren
Renovação de dias 4 ou menos.

Da um reboot todos os dias meia noite e cinco:
5 0 * * * /sbin/shutdown -r now

closesocks.sh
fecha todas as portas socks as 00:09 meia noite e meia:
30 0 * * * /usr/bin/closesocks.sh

abri as porta meia noite e 31:
checkport.sh $port
31 0 * * * /usr/bin/checkport.sh 8080
31 0 * * * /usr/bin/checkport.sh 8799


Bloquear multilogins 15 segundos sleep:
cd /usr/bin/
wget https://raw.githubusercontent.com/SpaceNetSA/backup_users/master/limiter_15.sh; chmod 777 limiter_15.sh

adiciona um screen que vai ficar verificando a cada 15s todos usuarios da vps se estao utilizando multilogins.
add line in /etc/autostart: ps x | grep 'limiter' | grep -v 'grep' && echo 'ON' || screen -dmS limiter15 /usr/bin/limiter_15.sh

ShellBot 6.3: Versão estável funcional.
