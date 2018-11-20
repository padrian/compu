#
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password qas123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password qas123'
sudo apt-get -y install mysql-server
sudo apt install automysqlbackup -y

## create mysql databases and users

mysql -u "$MYSQL_ROOT" -p "$MYSQL_PASS" -e "create database drupal;"
mysql -u "$MYSQL_ROOT" -p "$MYSQL_PASS" -e "create database civicrm;"

mysql -u "$MYSQL_ROOT" -p "$MYSQL_PASS" -e "CREATE USER '$DRUPAL_DB_USER'@'localhost' IDENTIFIED BY '$DRUPAL_DB_PASS';"
mysql -u "$MYSQL_ROOT" -p "$MYSQL_PASS" -e "GRANT ALL ON drupal.* TO '$DRUPAL_DB_USER'@'localhost' IDENTIFIED BY '$DRUPAL_DB_PASS' WITH GRANT OPTION;"
mysql -u "$MYSQL_ROOT" -p "$MYSQL_PASS" -e "GRANT ALL ON civicrm.* TO '$DRUPAL_DB_USER'@'localhost' IDENTIFIED BY '$DRUPAL_DB_PASS' WITH GRANT OPTION;"

## assign permisions to users for the databases
## assign permissions to civicrm database for drupal user;

## add jobs to crontab :)

(crontab -l 2>/dev/null; echo "09 00 * * * sudo automysqlbackup")| crontab -
crontab -l|sed "\$a00 01 * * * sudo /home/ubuntu/compu/backup/daily.sh"|crontab -
crontab -l|sed "\$a00 02 * * 2 sudo /home/ubuntu/compu/backup/weekly.sh"|crontab -
crontab -l|sed "\$a00 03 5 * 2 sudo /home/ubuntu/compu/backup/monthly.sh"|crontab -




