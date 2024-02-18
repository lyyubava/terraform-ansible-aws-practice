#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive

echo "${SSH_KEYS}" >>/root/.ssh/authorized_keys

apt-get update
apt-get -yq install \
    awscli \
    unzip \
    jq \
    nvme-cli
wget -O /tmp/ebsctl https://github.com/lyyubava/ebsctl-go/releases/download/v0.1.0/ebsctl_$(dpkg --print-architecture).tar
tar -xf /tmp/ebsctl -C /usr/sbin
rm /tmp/ebsctl
ebsctl --mountpoint ${MOUNTPOINT} --label data --mkfs ext4 --volume-id ${VOLUME_ID}
