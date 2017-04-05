FROM centos:7.3.1611
LABEL maintainer "Hiroyuki Wada <wadahiro@gmail.com>"

# system update
RUN yum -y update

# vsftpd & lsyncd
RUN yum -y install vsftpd epel-release \
  && sed -i -e "s/^#baseurl=/baseurl=/" /etc/yum.repos.d/epel.repo \
  && sed -i -e "s/^mirrorlist=/#mirrorlist=/" /etc/yum.repos.d/epel.repo \
  && yum -y install --enablerepo=epel lsyncd \
  && yum -y install awscli python-six supervisor rsyslog \
  && yum clean all


ENV FTP_USER=ftpuser \
    FTP_PASSWORD=password \
    AWS_ACCESS_KEY_ID= \
    AWS_SECRET_ACCESS_KEY= \
    AWS_DEFAULT_REGION=ap-northeast-1 \
    AWS_CLI_CONNECT_TIMEOUT=10 \
    AWS_CLI_READ_TIMEOUT=10 \
    AWS_CLI_RETRY=3 \
    AWS_S3_BUCKET= \
    AWS_S3_PREFIX= \
    LSYNCD_MAX_PROCESSES=10

RUN useradd -s /sbin/nologin $FTP_USER

COPY supervisord.conf /etc/supervisord.conf

COPY user_list /etc/vsftpd/
COPY vsftpd.conf /etc/vsftpd/
COPY lsyncd.conf /etc/lsyncd.conf
COPY stdout.conf /etc/rsyslog.d/


COPY docker-entrypoint.sh /usr/sbin/
RUN chmod +x /usr/sbin/docker-entrypoint.sh

EXPOSE 21

CMD ["/usr/sbin/docker-entrypoint.sh"]

