#!/bin/bash
clear
#Usuario e Validade tabela.
echo -e "\e[44;37;1m Usuario         Validade \e[m"
echo ""

#Função que retorna se a validade é igual a Venceu, Nunca ou número de dias.
for users in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |sort |grep -v "nobody" |grep -vi polkitd |grep -vi system-`
do
datauser=$(chage -l $users |grep -i co |awk -F : '{print $2}')

    databr="$(date -d "$datauser" +"%Y%m%d")"
    hoje="$(date -d today +"%Y%m%d")"
    if [ $hoje -ge $databr ]
    then
    data="\033[1;31mVenceu\033[0m"
    else  
    drest=$(expr $databr - $hoje)
    data=$drest
    fi

#dados mais importantes para trabalhar com api ou bot.
Usuario=$(printf ' %-15s' "$users")
Data=$(printf '%-1s' "$data")

#imprimi o nome do usuario e dias para expirar(dias, venceu ou nunca).
echo -e "\033[1;33m$Usuario \033[1;32m$Data\033[0m"
#linha sequencial que separa as informações de cada usuário.
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
done