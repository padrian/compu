# Configurations for CIVICRM and Drupal 7.61

Perform initial server setup with scripts, run.sh starts the setup
### setup of drupal

Please refer to scripts [ well commented ]
drush is uitilized to setup drupal and civicrm

### Backup

Automysql will be used to perform daily/weekly/monthly backups
backups will be sent to s3 bucket
Cronjobs are added to the crontab to enable automatic scheduled backups

### Monitoring

Monitoring and graphing will be achieved by a combination of prometheus and grafana setup ontop of docker

`
grafana: :3000
`

### Improvements

Add domain to enable creation of ssl certs from lets-encrypt 
create ansible playbook to automate the entire setup process
create IAC for the EC2 and S3 instance, cloudformation
create code definitions for the grafana dashboards to automate the entire monitoring setup
add exporters for mysql and nginx to keep track of resource uitilization