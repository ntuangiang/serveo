#!/usr/bin/env bash

# Function
write_host() {
  HOST_DOMAIN="host.docker.internal"
  INTERNAL_HOST_IP=$(ip route show default | awk '/default/ {print $3}')
  echo -e "$INTERNAL_HOST_IP\t$HOST_DOMAIN" >> /etc/hosts
}

write_ssh() {
  DIR=/root/.ssh
  FILE=/root/.ssh/known_hosts
  if [ ! -d "${DIR}" ]; then
    mkdir ${DIR}
  fi

  if [ ! -f "${FILE}" ]; then
    touch ${FILE}
  fi

  ssh-keyscan -t rsa serveo.net > ~/.ssh/known_hosts
}

write_host
write_ssh

if [ ! -n "${SERVEO_SUB_DOMAIN_PORT}" ]; then
  SERVEO_SUB_DOMAIN_PORT=80
fi

if [ ! -n "${SERVEO_PUBLISH_PROJECT_PORT}" ]; then
  SERVEO_PUBLISH_PROJECT_PORT=80
fi

if [ -n "${SERVEO_SSH_USER}" ]; then
    if [ -n "${SERVEO_SUB_DOMAIN}" ]; then
      ssh -R ${SERVEO_SUB_DOMAIN}:${SERVEO_SUB_DOMAIN_PORT}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} ${SERVEO_SUB_DOMAIN}@serveo.net
    else
      ssh -R ${SERVEO_SUB_DOMAIN_PORT}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} ${SERVEO_SUB_DOMAIN}@serveo.net
    fi
  else
    if [ -n "${SERVEO_SUB_DOMAIN}" ]; then
       ssh -R ${SERVEO_SUB_DOMAIN}:${SERVEO_SUB_DOMAIN_PORT}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} serveo.net
    else
       ssh -R ${SERVEO_SUB_DOMAIN_PORT}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} serveo.net
    fi
fi

