FROM lsiobase/xenial

ARG DEBIAN_FRONTEND="noninteractive"

RUN \
  apt-get update && \
  apt-get install -y apt-transport-https && \
  echo "deb https://releases.librevault.com/debian/ xenial/" >> /etc/apt/sources.list.d/librevault.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7ECABE6D2866013E2D9DB819F6CDDCEF4B158906 && \
  apt-get update && \
  apt-get install -y librevault

COPY /root/ /
