############################################################
#
# SCRIPT TO PULL WAN IP
# WAN IP IS WRITTEN TO LOG FILE
# WAN IP IS SENT TO EMAL MESSAGE WHICH IS SENT TWICE A DAY
#
############################################################

#!/bin/bash

#SET PATHS WHERE SCRIPT IS INSTALLED
PATH_sentEmailDirectory="[PATH FOR DATA]"
PATH_ipLogFile="[PATH FOR DATA]"

#FILES AND PATHS
emailSent="[PATH FOR SENT EMAILS]"
ipHistory="[LOG FILE PATH]"

currentIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
currentDate=$(date +"%Y%m%d_%T")

#DISPLAY CURRENT IP AND WRITE TO LOG FILE
echo "Your Current IP Is: $currentIP ... WRITING TO FILE NOW ..."
echo "$currentDate -- $currentIP" >> $PATH_ipLogFile$ipHistory

#WRITE CURRENT IP TO EMAIL AND LOG MESSAGE IN SENTEMAIL DIRECTORY
currentEmail="To:[SMTP EMAIL]\nFrom:[SMTP EMAIL]\nSubject:WAN IP - $currentIP\n\nCurrent WAN IP is: $currentIP"
fileName="$currentDate.sentEmail"
echo $currentEmail > $PATH_sentEmailDirectory$emailSent$fileName

#SEND EMAIL USING SSMTP
cat $PATH_sentEmailDirectory$emailSent$fileName | ssmtp [SMTP EMAIL]
echo "Email has been sent!" 
