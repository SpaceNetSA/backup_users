ren
Renovação de dias 4 ou menos.

Da um reboot todos os dias meia noite:
9 0 * * * /sbin/shutdown -r now

closesocks.sh
fecha todas as portas socks as 00:09 meia noite
9 0 * * * /usr/bin/closesocks.sh

checkport.sh $port
10 0 * * * /usr/bin/checkport.sh 8080
10 0 * * * /usr/bin/checkport.sh 8799

