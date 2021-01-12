#!/usr/bin/env bash
set -Eeuo pipefail

CONFIG_FILE="/var/atlas-probe/state/config.txt"
declare -a OPTIONS=(
	"RXTXRPT"
)

# Persistence dirs
mkdir -p /data/ripe_probe/status
mkdir -p /data/ripe_probe/etc
mkdir -p /data/ripe_probe/state
mkdir -p /tmpfs

# create essential files
mkdir -p /var/atlas-probe/status
mkdir -p /var/atlas-probe/etc
mkdir -p /var/atlas-probe/state
echo "" > "${CONFIG_FILE}"
cp -rf /var/atlas-probe/state/* /data/ripe_probe/state

# Internal binds
mount -o bind /data/ripe_probe/status /var/atlas-probe/status
mount -o bind /data/ripe_probe/etc /var/atlas-probe/etc
mount -o bind /data/ripe_probe/state /var/atlas-probe/state
mount -o bind /tmpfs /var/atlasdata
chmod 777 /tmpfs

# set probe configuration
for OPT in "${OPTIONS[@]}"; do
	if [ ! -z "${!OPT+x}" ]; then
		echo "Option ${OPT}=${!OPT}"
		echo "${OPT}=${!OPT}" >> "${CONFIG_FILE}"
	fi
done

if [ -f /var/atlas-probe/etc/probe_key.pub ]; then
	echo
	echo "THIS IS YOUR PUBLIC KEY:"
	echo
	cat /var/atlas-probe/etc/probe_key.pub
	echo
else
	echo
	echo "FIRST RUN! CREATING YOUR KEYS NOW!"
	echo "Restart this addon to see here you public key."
	echo
fi

exec gosu root:root "$@"
