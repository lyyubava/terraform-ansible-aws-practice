#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive

echo "${SSH_KEYS}" >>/root/.ssh/authorized_keys

apt-get update
apt-get -yq install \
    awscli \
    python3-pip \
    python3-jinja2 \
    python3-boto3 \
    unzip \
    jq \
    nvme-cli

mkdir -p ${MOUNTPOINT}
aws s3 cp s3://${BUCKET}/ebsctl/main.py /usr/sbin/ebsctl
chmod 0700 /usr/sbin/ebsctl
ebsctl --mountpoint ${MOUNTPOINT} --label data --mkfs ext4 --volume_id ${VOLUME_ID}
userdel ubuntu
