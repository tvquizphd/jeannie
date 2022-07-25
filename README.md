### Installing dependencies

Install php 8.0 and mysql 5.7:

```
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php

sudo apt install php8.0-fpm
sudo apt install php8.0-common php8.0-mysql php8.0-cgi php8.0-mbstring php8.0-curl php8.0-gd php8.0-xml php8.0-xmlrpc php8.0-zip

wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_8.0.28-1ubuntu20.04_amd64.deb-bundle.tar
tar -xvf mysql-server_8.0.28-1ubuntu20.04_amd64.deb-bundle.tar
sudo dpkg -i *.deb
apt --fix-broken install
sudo systemctl start mysql.service
```

You can remove the deb and tar files.

Create new database user account with `mysql -u root -p`:

```
CREATE USER 'j'@'localhost' IDENTIFIED BY '************';
GRANT ALL PRIVILEGES ON *.* TO 'j'@'localhost';
```

Then with `mysql -u j -p`:

```
CREATE DATABASE modx_modx;
```

### Installing ModX

Modify `/etc/php/8.0/*/php.ini`

```
pdo_mysql.default_socket = /var/run/mysqld/mysql.sock
mysqli.default_socket = /var/run/mysqld/mysql.sock
date.timezone = America/New_York
```

Copy `config.xml` as `secret_config.xml` with following changes:

Update `database_password`, `http_host`, `cmsadmin`, `cmspassword`.
Update `context_mgr_path`, `context_connectors_path`, `context_web_path`.

Then, install modx:

```
wget https://modx.com/download/direct/modx-3.0.1-pl-sdk.zip
wget https://raw.githubusercontent.com/craftsmancoding/modx_utils/master/installmodx.php
php installmodx.php --config=config.xml --zip=modx-3.0.1-pl-sdk.zip --target=/var/www/tvquizphd.com --version=3.0.1 --installmode=new
```

### Setup nginx

```
cp tvquizphd.com /etc/nginx/sites-available/tvquizphd.com
ln -s /etc/nginx/sites-available/tvquizphd.com /etc/nginx/sites-enabled/tvquizphd.com
```

Important:

```
nginx -t
systemctl restart nginx
```

### See if it works

Then open `www.tvquizphd.com` in Google Chrome.

### Backup

Backup the database, configs, and modx files:

```
bash make_backup.sh backup_dir secret_config.xml
```

Restore the database and modx files:

```
bash restore_backup.sh backup_dir
```
