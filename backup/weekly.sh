sudo s3cmd put -r /var/lib/automysqlbackup/weekly/ s3://compucorp-backups-bucket-00/weekly/
sudo rm /var/lib/automysqlbackup/weekly/*