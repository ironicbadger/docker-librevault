FROM lsiobase/xenial

ARG DEBIAN_FRONTEND="noninteractive"
ARG LIBREVAULT_CONTROL_LISTEN=42346
ARG LIBREVAULT_MULTICAST_GROUP=28914
ARG LIBREVAULT_P2P_LISTEN=42345
ARG LIBREVAULT_VERSION="0.1.18-85+ubuntu16.04"

EXPOSE ${LIBREVAULT_CONTROL_LISTEN} \
       ${LIBREVAULT_CONTROL_MULTICAST_GROUP} \
       ${LIBREVAULT_P2P_LISTEN}

# Allow the confiuration directory and the librevault data directory to be optionally mounted from the host for persistence
VOLUME ["/home/librevault/.config/Librevault", "/srv/librevault"]

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
    chown -R librevault:librevault /home/librevault/ \
                                   /srv/librevault

ENTRYPOINT ["/usr/bin/start"]