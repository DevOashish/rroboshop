
source common.sh

echo -e "\e[36m>>>>>>>>> Install python <<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>Add user <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>> Make app dir <<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download app content <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 

echo -e "\e[36m>>>>>>>>> Extract app content <<<<<<<<\e[0m"
cd /app 
unzip /tmp/payment.zip

# echo -e "\e[36m>>>>>>>>> Load Schema <<<<<<<<\e[0m"
# cd /app 

echo -e "\e[36m>>>>>>>>> Install dependencies <<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>> Sertup services <<<<<<<<\e[0m"
cp /home/centos/rroboshop/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>> Start and enable services <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment 
systemctl restart payment