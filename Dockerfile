FROM ubuntu:latest

MAINTAINER ntuangiang@outlook.com

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y apt-utils \
    openssh-server autossh \
    iputils-ping \
    iproute2 \
    vim

COPY  ./serveo.sh /serveo.sh

CMD ["/serveo.sh"]
