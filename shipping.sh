echo -e "\e[36m>>>>>>>>> Install Maven <<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>>>> Create App user <<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Delete the existing app and Create Application Directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download app content <<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 

echo -e "\e[36m>>>>>>>>> Move to app directory and Extract app content <<<<<<<<\e[0m"
cd /app 
unzip /tmp/shipping.zip

echo -e "\e[36m>>>>>>>>> Create Application Directory <<<<<<<<\e[0m"
cd /app 

echo -e "\e[36m>>>>>>>>> Download maven dependencies <<<<<<<<\e[0m"
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 


echo -e "\e[36m>>>>>>>>> Install MYSQL <<<<<<<<\e[0m"
yum install mysql -y 

echo -e "\e[36m>>>>>>>>> Load Schena <<<<<<<<\e[0m"
mysql -h mysql-dev.devoash.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql 


echo -e "\e[36m>>>>>>>>> Relaod and start shipping <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping 
systemctl restart shipping