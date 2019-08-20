FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y apt-utils \
    gettext-base \
    iputils-ping \
    iproute2 \
    vim openssh-server

COPY  ./serveo.sh /serveo.sh

CMD ["/serveo.sh"]
