FROM centos:7.3.1611
LABEL maintainer "Hiroyuki Wada <wadahiro@gmail.com>"

# system update
RUN yum -y update && yum clean all

# set locale
RUN yum reinstall -y glibc-common && yum clean all
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Japan /etc/localtime

# vsftpd & lsyncd
RUN yum -y install vsftpd epel-release && sed -i -e "s/^#baseurl=/baseurl=/" /etc/yum.repos.d/epel.repo && sed -i -e "s/^mirrorlist=/#mirrorlist=/" /etc/yum.repos.d/epel.repo && yum -y install --enablerepo=epel lsyncd && yum clean all


COPY user_list /etc/vsftpd/
COPY vsftpd.conf /etc/vsftpd/

RUN useradd -s /sbin/nologin admin && echo 'admin:password' | chpasswd 

COPY entry.sh /usr/sbin/
RUN chmod +x /usr/sbin/entry.sh

EXPOSE 21

CMD ["/usr/sbin/entry.sh"]

