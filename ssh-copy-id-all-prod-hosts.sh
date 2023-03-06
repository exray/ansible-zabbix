#!/bin/bash
for host_address in `cat ./docker-servers.txt`; do
    ssh-copy-id -i ~/.ssh/id_rsa.pub username@$host_address -p22
done