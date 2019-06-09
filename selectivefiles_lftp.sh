#!/bin/bash
read -p 'PROTOCAL   : ' PROTOCAL #FTP Port Protocal
read -p 'PORT       : ' PORT #FTP Port Number
read -p 'HOST       : ' HOST #FTP Host Name
read -p 'USER_NAME  : ' USER #FTP UserName
read -p 'PASSWORD   : ' PASSWORD #FTP Password
read -p 'DOMAIN_NAME: ' DOMAIN 

mkdir -p $(pwd)/${DOMAIN}
LPATH=$(pwd)/${DOMAIN} #$(pwd/${DOMAIN})  #Directory Where need to be Mirrored
InputFile=$( cat ./input.txt |tr "\n" " ") #Reading Files To Be Downloaded
RPATH=($InputFile) #Remote File Server's File Path

#Mirroring Function
mirroring() 
{
    mkdir -p ${LPATH}/${DirPATH}/
    cd ${LPATH}/${DirPATH}
	lftp ${PROTOCAL}://${USER}:${PASSWORD}@${HOST}:${PORT} -e "mirror -c --file='${i}'; && bye" #Fetching Files 

}

#Iterate file paths as input
for i in "${RPATH[@]}"
do
echo $i
DirPATH=$(dirname ${i})
if [ -d ${LPATH} ]
then	
	mirroring
fi
done
