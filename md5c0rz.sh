#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
PUR='\033[0;35m'
GRN="\e[32m"
WHI="\e[37m"
NC='\033[0m'

echo ""
printf "   $WHI ============================================================ \n"
printf "   $GRN #			$PUR c0rz ft AlchaDecode                   $GRN#\n"
printf "   $WHI ------------------------------------------------------------ \n"
printf "   $YELLOW			    MD5 Decryption								   "
printf "   $YELLOW			      TEL-U 2018			\n"
printf "   $WHI ============================================================ \n"
printf "$NC\n"


# Asking user whenever the
# parameter is blank or null
  # Print available file on
  # current folder
  # clear
  read -p "Show Directory Tree(Y/n): " show
  if [[ ${show,,} == 'y' ]]; then
  echo ""
  tree
  echo ""
  fi
  read -p "Enter mailist file: " inputFile
  if [[ ! $inputFile ]]; then
  printf "$YELLOW Please input the file \n"
  exit
  fi
  if [ ! -e $inputFile ]; then
  printf "$YELLOW File not found \n"
  exit
  fi
  
  if [[ $targetFolder == '' ]]; then
  read -p "Enter target folder: " targetFolder
  # Check if result folder exists
  # then create if it didn't
  if [[ ! $targetFolder ]]; then
  echo "Creating Hasil/ folder"
    mkdir Hasil
    targetFolder="Hasil"
  fi
  if [[ ! -d "$targetFolder" ]]; then
    echo "Creating $targetFolder/ folder"
    mkdir $targetFolder
  else
    read -p "$targetFolder/ folder exists, append to them?(Y/n): " isAppend
    if [[ $isAppend == 'n' ]]; then
    printf "$YELLOW == Thanks For Using AlcSec == \n"
      exit
    fi
  fi
else
  if [[ ! -d "$targetFolder" ]]; then
    echo "Creating $targetFolder/ folder"
    mkdir $targetFolder
  fi
fi
totalLines=`grep -c "@" $inputFile`
con=1
printf "$CYAN=================================\n"
printf "$YELLOW       CHECKING PROCESS\n"
printf "$CYAN=================================\n"
check(){
header="`date +%H:%M:%S`"
cr0z=$(curl -s 'https://lea.kz/api/hash/'$2'' -H 'Cache-Control: no-cache');
creep=$(echo "$cr0z" | grep -Po '(?<="password": ")[^"]*');
if [[ $cr0z = *'"password"'* ]]; then
  printf "$ORANGE[$header] $NC $email |$YELLOW $creep \n";
  echo "$1|$creep" >> $3/ResultLive.tmp
else
  printf "$ORANGE[$header] $NC $email |$RED $2 \n";
  echo "$1|$2" >> $3/ResultDie.tmp
fi
}
SECONDS=0
for mailpass in $(cat $inputFile); do
	email=$(echo $mailpass | cut -d "|" -f 1)
	pass=$(echo $mailpass | cut -d "|" -f 2)
	jmail=${#email}
	jpass=${#pass}
	indexer=$((con++))
	printf "$CYAN $totalLines/$indexer - "
	check $email $pass $targetFolder
done
duration=$SECONDS
printf "$YELLOW $(($duration / 3600)) hours $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed. \n"
printf "$YELLOW=============== AlcSec - AlchaDecode =============== \n"