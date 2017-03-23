#!/bin/bash                                                                                                                                                             │····································································
# we pass all domains access log to one nginx and parse it
#recent chinese ips trying to send spam through wordpress share via email...we blocked share via email plugin/addon but the chinese ips
#continue trying to access it.
#currently this script blocked: 4550 IPs from china
#115.216.39.231 - - [23/Mar/2017:09:44:12 +0200] "POST /%d0%bc%d0%b5%d1%81%d1%82%d0%be%d0%bf%d0%be%d0%bb%d0%be%d0%b6%d0%b5%d0%bd%d0%b8%d0%b5/?share=email&nb=1 HTTP/1.1" │····································································
#200 12967 "http://**********/%d0%bc%d0%b5%d1%81%d1%82%d0%be%d0%bf%d0%be%d0%bb%d0%be%d0%b6%d0%b5%d0%bd%d0%b8%d0%b5/?share=email&nb=1" "Mozilla/5.0 (Windows NT 6.1;│····································································
# Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.99 Safari/537.36"        ············································



for domain in `cat /var/log/nginx/access.log | grep ?share | awk '{print $1}' | sort  | uniq -u`                                                                        │····································································
do                                                                                                                                                                      │····································································
        whois $domain | if grep -c China > 1; then echo "banning.."$domain;                                                                                             │····································································
        shorewall drop $domain                                                                                                                                          │····································································
fi                                                                                                                                                                      │····································································
done 
