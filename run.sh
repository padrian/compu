## git clone https://github.com/padrian/compu.git && cd compu

## initial installations
sudo apt-get install nginx -y
sudo cp default /etc/nginx/sites-available/
sudo systemctl restart nginx.service

sudo ./config.sh # setup db configuration variables
sudo ./db_setup.sh

sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C -y
sudo apt update -y
sudo apt install php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-mcrypt php-ldap php-zip php-curl -y
sudo apt-get install php-xml -y
sudo apt-get install drush -y && su ubuntu && drush #install and initialise drush

## drupal download and setup with drush
sudo drush dl 'drupal-7.61' --destination='/var/www/' --drupal-project-rename='compu' -y
sudo chmod -R 755 /var/www/compu/
sudo chown -R www-data:www-data /var/www/compu/

sudo drush site-install --yes standard --root=/var/www/compu \
--account-name='padrian' --account-pass='compucorp123' \
--db-url=mysql://root:'qas123'@localhost/drupal \
--account-mail='padrian@gmail.com' --site-name='compucorp' \
--site-mail='padrian.baba@gmail.com'

cd /var/www/ && sudo drush en views -y # dl and enable views module
sudo drush cache-clear drush

## setup civicrm

cd /tmp && wget https://download.civicrm.org/civicrm-5.7.0-drupal.tar.gz
tar -xvf civicrm-5.7.0-drupal.tar.gz
cp civicrm/drupal/drush/civicrm.drush.inc /home/ubuntu/.drush/
chmod 640 /home/ubuntu/.drush/civicrm.drush.inc 
sudo drush cache-clear drush

sudo drush civicrm-install --dbhost=localhost:3306 \
 --dbname=civicrm --dbuser=root \
 --dbpass=qas123 --destination=sites/all/modules \
 --tarfile=/tmp/civicrm-5.7.0-drupal.tar.gz --root=/var/www/compu

sudo drush cache-clear drush

#cleanup after civi install
rm /var/www/compucorp/sites/all/modules/civicrm/drupal/drush/civicrm.drush.inc
rm /home/ubuntu/.drush/civicrm.drush.inc

# folder for civi extensions
mkdir /var/www/compu/sites/default/civicrm_extensions

## fix civicrm permisions

chmod -R 755 /var/www/compu/sites/all/modules/civicrm/
chown -R www-data:www-data /var/www/compu/sites/all/modules/civicrm/

chmod -R 755 /var/www/compu/sites/default/files/civicrm/
chown -R www-data:www-data /var/www/compu/sites/default/files/civicrm/

sudo systemctl restart nginx.service

## setup docker and run stack
cd /home/ubuntu/compu/ && sudo ./docker.sh
docker build -t padriano/prom:latest .
