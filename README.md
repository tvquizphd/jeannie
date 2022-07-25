### Installing dependencies

Install php 8.0 and mysql 5.7:

```
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php

sudo apt install php8.0-fpm
sudo apt install php8.0-common php8.0-mysql php8.0-cgi php8.0-mbstring php8.0-curl php8.0-gd php8.0-xml php8.0-xmlrpc php8.0-zip

wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_5.7.37-1ubuntu18.04_amd64.deb-bundle.tar
tar -xvf mysql-server_5.7.37-1ubuntu18.04_amd64.deb-bundle.tar
sudo dpkg -i *.deb
sudo systemctl start mysql.service
```

Create new database user account with `mysql -u root -p`:

```
CREATE USER 'j'@'localhost' IDENTIFIED BY '************';
```

Then with `mysql -u j -p`:

````
CREATE DATABASE modx_modx;
```

### Installing ModX

Modify `/etc/php/8.0/*/php.ini`

```
pdo_mysql.default_socket = /var/run/mysqld/mysql.sock
mysqli.default_socket = /var/run/mysqld/mysql.sock
date.timezone = America/New_York
```

Run `msql -u j -p`

```
create database modx_modx
```

```
wget https://modx.com/download/direct/modx-3.0.1-pl-sdk.zip
wget https://raw.githubusercontent.com/craftsmancoding/modx_utils/master/installmodx.php
php installmodx.php --config=config.xml --zip=modx-3.0.1-pl-sdk.zip --target=jeannie.example.com --version=3.0.1 --installmode=new
```

Then open `jeannie.example.com` in Google Chrome.
