source common.sh 

yum install golang -y

useradd ${app_user}

rm -rf /app
mkdir /app 

curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
unzip /tmp/dispatch.zip
cd /app 
go mod init dispatch
go get 
go build

systemctl daemon-reload

systemctl enable dispatch.service
systemctl restart dispatch.service