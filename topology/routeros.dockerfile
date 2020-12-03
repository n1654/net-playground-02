FROM alpine:latest

RUN mkdir /routeros
WORKDIR /routeros
COPY . /routeros

RUN apk add --no-cache --update netcat-openbsd qemu-x86_64 qemu-system-x86_64
RUN apk add --no-cache busybox-extras iproute2 iputils bridge-utils iptables bash
RUN wget "https://download.mikrotik.com/routeros/6.47.1/chr-6.47.1.vdi"

RUN ["chmod", "+x", "/routeros/entrypoint.sh"]
ENTRYPOINT ["/routeros/entrypoint.sh"]
