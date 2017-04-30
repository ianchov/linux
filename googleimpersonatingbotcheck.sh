#!/bin/bash
#Run every 6 or 12 hours
#finds all ips if google bot is present and checks if the ips belongs to Google
#if not the ip is blocked, then reported to abuseipdb.com and 
#then an email is send to the manager of the Subnet found via whois search

ips=`grep -i Googlebot /var/log/nginx/access.log | awk '{print $1}' | sort -u`
echo "Total " ${#ips}

for ip in $ips
        do
        #echo $ip
        #if  `whois $ip | grep -qi google`
        if `host $ip | grep -qi google`
        then
                #echo 'found google'
                :
        else
        echo $ip "is impersinating google bot";
        shorewall drop $ip
        email=`whois $ip | grep @ | grep -v "^$" | grep -v "^%" | awk '{ print $2 }' | tail -n 1`
        printf "Reporting to abuseip\n"
        curl 'https://www.abuseipdb.com/report/json?key=*********************&category=21,19&comment=Impersonating google bot&ip='$ip
        printf "Sending mail from whois DB\n"
        php /usr/local/sbin/elasticimpersonatingbot.php $email
        fi
done
printf "Finished!\n"
