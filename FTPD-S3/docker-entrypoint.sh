#!/bin/bash

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log

