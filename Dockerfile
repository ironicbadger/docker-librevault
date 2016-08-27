FROM ubuntu:xenial
MAINTAINER sparkly[blue]balls

# Websockets
EXPOSE 42345
EXPOSE 42346

# Multicast Discovery
EXPOSE 28914

ARG DEBIAN_FRONTEND="noninteractive"
              
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    echo "deb https://releases.librevault.com/debian/ xenial/" >> /etc/apt/sources.list.d/librevault.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7ECABE6D2866013E2D9DB819F6CDDCEF4B158906 && \
    apt-get update && \
    apt-get install -y librevault && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /var/tmp/* && \
    mkdir /srv/librevault && \
    useradd -m librevault && \
    chmod 755 /srv/librevault && \
    chown librevault:librevault /srv/librevault

# Isolate it away from root (just in case cuz you know stuffz is "always" secure)
USER librevault

ENTRYPOINT ["/usr/bin/librevault-daemon", "--data", "/srv/librevault"]