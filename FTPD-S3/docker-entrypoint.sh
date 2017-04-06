#!/bin/bash

# modify rsyslogd configs
sed 's/^$ModLoad imjournal/# $ModLoad imjournal/' -i /etc/rsyslog.conf
sed 's/^$OmitLocalLogging on/$OmitLocalLogging off/' -i /etc/rsyslog.conf
sed 's/^$IMJournalStateFile imjournal.state/# $IMJournalStateFile imjournal.state/' -i /etc/rsyslog.conf
sed 's/^$SystemLogSocketName /# $SystemLogSocketName /' -i /etc/rsyslog.d/listen.conf


# set ftpuser password
echo $FTP_USER:$FTP_PASSWORD | chpasswd

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION


# modify lsyncd.conf
sed -i -e "s|@LSYNCD_MAX_PROCESSES@|$LSYNCD_MAX_PROCESSES|" /etc/lsyncd.conf
sed -i -e "s|@AWS_S3_BUCKET@|$AWS_S3_BUCKET|" /etc/lsyncd.conf
sed -i -e "s|@AWS_S3_PREFIX@|$AWS_S3_PREFIX|" /etc/lsyncd.conf


# start supervisord
/usr/bin/supervisord -c /etc/supervisord.conf

