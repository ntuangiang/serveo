#!/usr/bin/env bash

INTERNAL_HOST_IP=$(ip route show default | awk '/default/ {print $3}')
HOST_DOMAIN="host.docker.internal"

echo -e "$HOST_IP\t$HOST_DOMAIN" >> /etc/hosts

mkdir "/root/.ssh" && touch "/root/.ssh/known_hosts"
ssh-keyscan -t rsa serveo.net > ~/.ssh/known_hosts

if [ -n "${SERVEO_SSH_USER}" ]; then
  ssh -R ${SERVEO_SUB_DOMAIN}:${SERVEO_SUB_DOMAIN_PORT}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} ${SERVEO_SUB_DOMAIN}@serveo.net
else
  ssh -R ${SERVEO_SUB_DOMAIN}:${SERVEO_SUB_DOMAIN_PORT}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} serveo.net
fi
