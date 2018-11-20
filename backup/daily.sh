sudo s3cmd put -r /var/lib/automysqlbackup/daily/ s3://compucorp-backups-bucket-00/daily/
sudo rm /var/lib/automysqlbackup/daily/*