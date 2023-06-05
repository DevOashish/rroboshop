cp mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org -y
sudo sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
systemctl enable mongodb 
systemctl restart mongodb
