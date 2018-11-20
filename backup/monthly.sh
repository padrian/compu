sudo s3cmd put -r /var/lib/automysqlbackup/monthly/ s3://compucorp-backups-bucket-00/
sudo rm /var/lib/automysqlbackup/monthly/*