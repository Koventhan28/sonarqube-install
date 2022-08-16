#!/bin/bash
#!/usr/bin/expect -f 
# Need to set environment variable USER_PASSWORD
echo -e "vm.max_map_count=262144\nfs.file-max=65536\nulimit -n 65536\nulimit -u 4096\n" >> /etc/sysctl.conf
echo -e "sonarqube - nofile 65536\nsonarqube - nproc 4096" >> /etc/security/limits.conf
sudo su - 
sudo apt-get install openjdk-11-jdk -y
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt install postgresql postgresql-contrib -y
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo passwd postgres
expect "assword:"
send -- "$env(USER_PASSWORD)\r"
expect eof
su - postgres
createuser sonar


