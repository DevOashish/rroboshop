echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Config Node.js <<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install Node.js <<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Add user <<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> remove app <<<<<<<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> make dir <<<<<<<<<<<<<<<\e[0m"
mkdir /app 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> cart zip <<<<<<<<<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> go to app dir <<<<<<<<<<<<<<<\e[0m"
cd /app 


echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> unzip in dir <<<<<<<<<<<<<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> go to dir <<<<<<<<<<<<<<<\e[0m"
cd /app

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> install npm <<<<<<<<<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> cp to cart service <<<<<<<<<<<<<<<\e[0m"
cp cart.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> system enable and start <<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart 
systemctl start cart