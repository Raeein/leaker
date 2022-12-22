FROM socsguelph/socslinux:latest

RUN apt-get clean all \
    apt-get update \
    apt-get full-upgrade -y --allow-downgrades \
    apt-get install -y --no-install-recommends build-essential build-essential \
    /

RUN mkdir -p /root/build
VOLUME /root/build
WORKDIR /root/build
COPY entry.sh .
RUN chmod +x entry.sh

ENTRYPOINT [ "./entry.sh" ]
