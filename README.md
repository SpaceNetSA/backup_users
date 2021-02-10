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

