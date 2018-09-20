FROM debian

ARG DEBIAN_FRONTEND=noninteractive
ARG UNAME=getssl
ARG UID=1000
ARG GID=1000

RUN apt-get update &&\
 apt-get install -y --no-install-recommends\
 ca-certificates\
 curl\
 dnsutils\
 libltdl7\
 openssh-client &&\
 curl https://raw.githubusercontent.com/srvrco/getssl/master/getssl > /usr/local/bin/getssl &&\
 chmod 755 /usr/local/bin/getssl &&\
 groupadd -g $GID $UNAME && \
 useradd -m -u $UID -g $GID $UNAME &&\
 rm -rf /var/lib/apt/lists/*

USER $UNAME

WORKDIR /home/$UNAME

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
