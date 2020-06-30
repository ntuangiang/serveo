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

validate_parameters() {
  if [ ! -n "${SERVEO_SUB_DOMAIN_PORT}" ]; then
    SERVEO_SUB_DOMAIN_PORT=80
  fi

  if [ ! -n "${SERVEO_PUBLISH_PROJECT_PORT}" ]; then
    SERVEO_PUBLISH_PROJECT_PORT=80
  fi
}

get_serveo_subdomain() {
  SUB_DOMAIN=
  if [ -n "${SERVEO_SUB_DOMAIN}" ]; then
    SUB_DOMAIN="${SERVEO_SUB_DOMAIN}:${SERVEO_SUB_DOMAIN_PORT}"
  else
    SUB_DOMAIN="${SERVEO_SUB_DOMAIN_PORT}"
  fi
}

get_serveo_ssh_subdomain() {
  SUB_SSH_DOMAIN_INFO=
  if [ -n "${SERVEO_SSH_USER}" ]; then
    SUB_SSH_DOMAIN_INFO="${SERVEO_SSH_USER}@serveo.net"
  else
    SUB_SSH_DOMAIN_INFO="serveo.net"
  fi
}

write_host
write_ssh

if [ -n "${SERVEO_CUSTOM_COMMAND}" ]; then
  ${SERVEO_CUSTOM_COMMAND}
else
  validate_parameters
  get_serveo_subdomain
  get_serveo_ssh_subdomain

  echo "yes | ssh -R ${SUB_DOMAIN}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} ${SUB_SSH_DOMAIN_INFO}"
  yes | ssh -R ${SUB_DOMAIN}:${SERVEO_PUBLISH_PROJECT}:${SERVEO_PUBLISH_PROJECT_PORT} ${SUB_SSH_DOMAIN_INFO}
fi



