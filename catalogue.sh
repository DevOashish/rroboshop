echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Config Node.js <<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install Nodejs <<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Add user roboshop <<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> create directory app <<<<<<<<<<<<<<<\e[0m"
mkdir /app 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> creat zip file <<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> go to app dir <<<<<<<<<<<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> unzip catalogue zip file <<<<<<<<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install npm <<<<<<<<<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> copy file <<<<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> system reload <<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> enable system <<<<<<<<<<<<<<<\e[0m"
systemctl enable catalogue 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> system start <<<<<<<<<<<<<<<\e[0m"
systemctl start catalogue

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> copy mongodbrepo <<<<<<<<<<<<<<<\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install mongodb <<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> monogodb dns <<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.devoash.tech </app/schema/catalogue.js 