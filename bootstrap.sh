#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='hello'

# ---------------------------------------
#          Virtual Machine Setup
# ---------------------------------------

# Adding multiverse sources.
cat > /etc/apt/sources.list.d/multiverse.list << EOF
deb http://archive.ubuntu.com/ubuntu bionic multiverse
deb http://archive.ubuntu.com/ubuntu bionic-updates multiverse
deb http://security.ubuntu.com/ubuntu bionic-security multiverse
EOF

# Updating packages
apt-get update

# ---------------------------------------
#          Apache Setup
# ---------------------------------------

# Installing Packages
apt-get install -y apache2

# linking Vagrant directory to Apache 2.4 public directory
rm -rf /var/www
ln -fs /vagrant /var/www

# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/var/www"
  ServerName localhost
  <Directory "/var/www">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

# Loading needed modules to make apache work
service apache2 reload


# ---------------------------------------
#          PHP Setup
# ---------------------------------------

# add  Ondrej PHP repository
add-apt-repository ppa:ondrej/php
#  update your system’s repository index
apt-get update
#  install PHP 5.6
apt-get install -y php5.6

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo apt-get install php5.6-mysql


# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin


# install git
sudo apt-get -y install git

# Install Yii 1 in /var/www/yii
cd /var/www/yii
git pull https://github.com/yiisoft/yii.git

# Create test Yii application
echo "yes" | /var/www/yii/framework/yiic webapp /var/www/testdrive

#mkdir /var/www/testdrive/protected/runtime
#chmod a+w /var/www/testdrive/protected/runtime