#!/bin/bash

# rsyslog
sed 's/$ModLoad imjournal/# $ModLoad imjournal/' -i /etc/rsyslog.conf
sed 's/$OmitLocalLogging on/$OmitLocalLogging off/' -i /etc/rsyslog.conf
sed 's/$IMJournalStateFile imjournal.state/# $IMJournalStateFile imjournal.state/' -i /etc/rsyslog.conf
sed 's/$SystemLogSocketName /# $SystemLogSocketName /' -i /etc/rsyslog.d/listen.conf


# set ftpuser password
echo $FTP_USER:$FTP_PASSWORD | chpasswd

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION


# start lsyncd
sed -i -e "s|@LSYNCD_TARGET@|$LSYNCD_TARGET|" /etc/lsyncd.conf
/bin/lsyncd /etc/lsyncd.conf

# start supervisord
/usr/bin/supervisord -c /etc/supervisord.conf

