#!/bin/bash

#Colours
purple='\033[1;35m'
yellow='\033[1;33m'
cyan="\033[1;36m"

#Introduction about the project
echo -n -e "${yellow} Welcome to Show-Me-The-Hacks\n\n"
echo -n -e "${yellow} We will fetch the hackathons currently listed on Devfolio for  you\n\n"

#Getting Data
echo -n -e "${cyan} Getting Required Data......\n\n"
n=$(curl -s https://devfolio.co/hackathons | pup 'h5.bfNete text{}' | wc -l)
for (( f=1 ; f<=$(($n)); f++  )); do
     if [ $(($f%2)) == 0 ]; then
        echo -e "$purple[$f]  "$(curl -s "https://devfolio.co/hackathons" | pup 'h5.bfNete text{}' | head -$f | tail -1)       
     else
        echo -e "$yellow[$f]  "$(curl -s "https://devfolio.co/hackathons" | pup 'h5.bfNete text{}' | head -$f | tail -1)
     fi
done

#Making a Choice
echo -n -e "${cyan} Which One do you want to know about?:  "
read op
hack=$(curl -s https://devfolio.co/hackathons | pup 'a.fJPiKJ attr{href}' | head -${op} | tail -1) 
curl -s $hack | pup 'p.hhjaty text{}'

#Asking if user wants to apply
echo ""
echo -n -e "${yellow}Do you want to apply to this Hackathon? [Y/N]: "
read ch
if [ "${ch}" = "Y" ]; then
	brave "${hack}"
fi
