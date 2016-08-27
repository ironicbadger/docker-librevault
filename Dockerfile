FROM ubuntu:xenial
MAINTAINER sparkly[blue]balls

ARG DEBIAN_FRONTEND="noninteractive"
ARG LIBREVAULT_VERSION="0.1.18-85+ubuntu16.04"

# Websockets
EXPOSE 42345
EXPOSE 42346

# Multicast Discovery
EXPOSE 28914

# Allow the main directory to be optionally mounted from the host for persistence
VOLUME ["/srv/librevault"]

COPY docker/ /
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    echo "deb https://releases.librevault.com/debian/ xenial/" >> /etc/apt/sources.list.d/librevault.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7ECABE6D2866013E2D9DB819F6CDDCEF4B158906 && \
    apt-get update && \
    apt-get install -y librevault=${LIBREVAULT_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /var/tmp/* && \
    useradd -m librevault && \
    chmod 755 /srv/librevault \
              /usr/bin/start && \
    chown librevault:librevault /srv/librevault

ENTRYPOINT ["/usr/bin/start"]