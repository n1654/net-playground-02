FROM alpine:latest

COPY ./entrypoint.sh /
COPY ./b.ipsec.conf /etc/ipsec.conf
COPY ./ipsec.secrets /etc/ipsec.secrets

RUN apk add openssh bash strongswan --no-cache
RUN echo -e "Port 22\n\
AddressFamily any\n\
ListenAddress 0.0.0.0\n\
PermitRootLogin yes\n\
PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN echo root:root123 | chpasswd

RUN /usr/bin/ssh-keygen -A
RUN ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
