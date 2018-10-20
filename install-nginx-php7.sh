#!/bin/sh
#sed -i -e 's/\r$//' your_script.sh

#install library
apt-get install systemd -y		#install systemctl

apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev unzip

#install nginx 1.15.5
wget https://github.com/scorpio7x/nginx/raw/master/nginx-1.15.5.tar.gz

tar -xvzf nginx-1.15.5.tar.gz

cd nginx-1.15.5

./configure

make

make install

/usr/local/nginx/sbin/nginx

cd ..

rm -rfv nginx-1.15*

#install php7
apt-get install python-software-properties -y

add-apt-repository ppa:ondrej/php

apt-get update

apt-get install php7.0-fpm php7.0-mysql php7.0-curl php7.0-zip php7.0-intl php7.0-gd php7.0-mbstring php7.0-mcrypt php7.0-simplexml -y

wget https://github.com/scorpio7x/nginx-php7/raw/master/php.ini

rm -rfv /etc/php/7.0/fpm/php.ini

mv -fv php.ini /etc/php/7.0/fpm/

wget https://github.com/scorpio7x/nginx-php7/raw/master/www.conf

rm -rfv /etc/php/7.0/fpm/pool.d/www.conf

mv -fv www.conf /etc/php/7.0/fpm/pool.d/

service php7.0-fpm restart

mkdir /usr/local/nginx/conf.d

wget https://github.com/scorpio7x/nginx-php7/raw/master/server.conf

mv -fv server.conf /usr/local/nginx/conf.d/

wget https://github.com/scorpio7x/nginx-php7/raw/master/nginx.conf

rm -rfv /usr/local/nginx/conf/nginx.conf

mv -fv nginx.conf /usr/local/nginx/conf/

/usr/local/nginx/sbin/nginx -s reload

#install service nginx
wget https://github.com/scorpio7x/nginx-php7/raw/master/nginx-service.sh

mv -fv nginx-service.sh /etc/init.d/nginx
 
chmod +x /etc/init.d/nginx

/usr/sbin/update-rc.d -f nginx defaults

service nginx reload

#create phpinformation page
echo "<?php phpinfo(); ?>" >> /usr/local/nginx/html/info.php

chmod -R 755 /usr/local/nginx/html/

#install mariadb-server mysql
apt-get install software-properties-common -y
	
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
	
add-apt-repository 'deb http://download.nus.edu.sg/mirror/mariadb/repo/10.3/ubuntu trusty main'
	
apt-get update

apt-get install mariadb-server -y

mysql_secure_installation

#install phpmyadmin
#wget https://files.phpmyadmin.net/phpMyAdmin/4.8.3/phpMyAdmin-4.8.3-all-languages.zip
wget https://github.com/scorpio7x/nginx-php7/raw/master/phpMyAdmin-4.8.3-all-languages.zip
	
unzip phpMyAdmin-4.8.3-all-languages.zip
	
mv -fv phpMyAdmin-4.8.3-all-languages phpmyadmin
	
mv -fv phpmyadmin /usr/share/

rm -rfv phpMyAdmin-4.8.3-all-languages.zip

wget https://github.com/scorpio7x/nginx-php7/raw/master/config.inc.php

mv -fv config.inc.php /usr/share/phpmyadmin/

ln -s /usr/share/phpmyadmin /usr/local/nginx/html
	
mkdir /usr/share/phpmyadmin/tmp

chmod -R 777 /usr/share/phpmyadmin/tmp

clear && echo && echo 'Install successful !'


