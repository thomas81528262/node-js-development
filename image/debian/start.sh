#!/bin/bash

__create_user() {
# Create a user to SSH into as.
echo -e "$ROOT_PASSWD\n$ROOT_PASSWD" | (passwd --stdin root)
echo ssh root password: $ROOT_PASSWD
}

# Call all functions
__create_user

mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

ip link set dev eth0 mtu 1450

dockerd & /usr/sbin/sshd -D 
