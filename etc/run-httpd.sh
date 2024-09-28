#!/bin/bash

service apache2 restart
service inetutils-syslogd start
service fail2ban start

touch ~/placeholder.txt
tail -f ~/placeholder.txt
