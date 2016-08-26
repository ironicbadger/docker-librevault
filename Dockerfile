FROM lsiobase/xenial

RUN \
  apt-get update && \
  apt-get install -y apt-transport-https lsb-release && \
  echo deb https://releases.librevault.com/debian/ $(lsb_release -cs)/ \
      | tee /etc/apt/sources.list.d/librevault.list && \
  cat /etc/apt/sources.list.d/librevault.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7ECABE6D2866013E2D9DB819F6CDDCEF4B158906 && \
  apt-get update && \
  apt-get install -y librevault

CMD ["librevault-daemon"]
