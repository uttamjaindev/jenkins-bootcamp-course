#!/bin/bash

# Update from OS install
apt-get update -y

# Common utilities
apt-get install -y nano zip unzip wget curl nginx

cd /etc/nginx/sites-available
wget https://raw.githubusercontent.com/jenkins-training/jenkins-bootcamp-course/master/aws/lightsail/scale/web.conf

# remove default symlink
cd /etc/nginx/sites-enabled
rm default
ln -s ../sites-available/web.conf web.conf

mkdir -p /var/log/nginx/jenkins
cd /var/log/nginx
chown www-data.adm jenkins

mkdir -p /var/www/jenkins
cd /var/www/jenkins
wget https://raw.githubusercontent.com/jenkins-training/jenkins-bootcamp-course/master/aws/lightsail/scale/index.html
chmod 644 index.html

cd
nginx -t

systemctl restart nginx
systemctl enable nginx

wget https://raw.githubusercontent.com/jenkins-training/jenkins-bootcamp-course/master/aws/lightsail/scale/secure-web.sh
chmod 755 secure-web.sh

apt-get update -y
apt-get install -y software-properties-common
add-apt-repository ppa:certbot/certbot -y
apt-get update -y
apt-get install -y python-certbot-nginx

# Once complete, login as root and run command:
# ./secure-web.sh domain.name email@domain.name
