#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with
# special-character passwords
PASSWORD='hello'

# ---------------------------------------
#          Virtual Machine Setup
# ---------------------------------------

# Add multiverse sources
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

# dd  Ondrej PHP repository
add-apt-repository ppa:ondrej/php
#  Update system repository index
apt-get update
#  Install PHP 5.6
apt-get install -y php5.6

# ---------------------------------------
#          MySQL Setup
# ---------------------------------------

# Install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server mysql-client
sudo apt-get install php5.6-mysql

# Install phpmyadmin and give passwords to installer
# For simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

# Allow external connections on MySQL service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -p$PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASSWORD'; FLUSH privileges;"
sudo service mysql restart

# ---------------------------------------
#          Yii 1 and test application setup
# ---------------------------------------

# install git
sudo apt-get -y install git

# Install Yii 1 in /var/www/yii
cd /var/www/yii
git pull https://github.com/yiisoft/yii.git

# Create testdrive mysql database
mysql -u root -p$PASSWORD <<EOF
create database testdrive;
use testdrive;
source /var/www/testdrive/protected/data/schema.mysql.sql;
EOF

# Execute database migrations
echo "yes" | /var/www/testdrive/protected/yiic migrate