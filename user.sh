echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
cd /app 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user 
systemctl start user

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
cp /home/centos/rroboshop/mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.devoash.tech </app/schema/catalogue.js
