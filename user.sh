echo -e "\e[31m>>>>>>>>>>>>>>>>>>>> configure nodejs <<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> Install nodejs  <<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> Add user roboshop <<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> remove app dir <<<<<<<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> make dir app <<<<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[33m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
cd /app 

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[32m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
npm install

echo -e "\e[34m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
cp /home/centos/rroboshop/user.service /etc/systemd/user.service

echo -e "\e[35m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user 
systemctl restart user

echo -e "\e[35m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
cp /home/centos/rrobosshop/mongodb.repo /etc/yum.repos.d/mongodb.repo



echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.devoash.tech </app/schema/user.js
