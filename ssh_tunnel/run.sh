#!/usr/bin/with-contenv bashio
set -e

CONFIG_PATH=/data/options.json
KEY_PATH=/data/ssh_keys

HOSTNAME="$(bashio::config 'hostname')"
SSH_PORT="$(bashio::config 'ssh_port')"
USERNAME="$(bashio::config 'username')"
REMOTE_FORWARDING="$(bashio::config 'remote_forwarding')"
LOCAL_FORWARDING="$(bashio::config 'local_forwarding')"
OTHER_SSH_OPTIONS="$(bashio::config 'other_ssh_options')"
ALIVE_INTERVAL="$(bashio::config 'server_alive_interval')"
ALIVE_COUNT="$(bashio::config 'server_alive_count_max')"

if [ ! -d "$KEY_PATH" ]; then
    echo "Key Generation..."
    mkdir -p "$KEY_PATH"
    ssh-keygen -o -t ed25519 -N "" -f "${KEY_PATH}/autossh_key"
fi

echo "Your public key is: "
cat "${KEY_PATH}/autossh_key.pub"

command_args="-M 0 -N -q -o ServerAliveInterval=${ALIVE_INTERVAL} -o ServerAliveCountMax=${ALIVE_COUNT} ${USERNAME}@${HOSTNAME} -p ${SSH_PORT} -i ${KEY_PATH}/autossh_key"

if [ ! -z "$REMOTE_FORWARDING" ]; then
  while read -r line; do
    command_args="${command_args} -R $line"
  done <<< "$REMOTE_FORWARDING"
fi

if [ ! -z "$LOCAL_FORWARDING" ]; then
  while read -r line; do
    command_args="${command_args} -L $line"
  done <<< "$LOCAL_FORWARDING"
fi

command_args="${command_args} ${OTHER_SSH_OPTIONS}"

echo "Running autossh: ${command_args}"
/usr/bin/autossh ${command_args}
