app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

print_head() {
  echo -e "\e[35m>>>>>>>>> $1 <<<<<<<<\e[0m"
}

 schema_setup() {

   if [ "$schema_setup" == "mongo" ]; then
    print_head "Copy MongoDB repo"
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo


     print_head "Install MongoDB Client"
     yum install mongodb-org-shell -y

     print_head "Load Schema"
     mongo --host mongodb-dev.devoash.tech </app/schema/${component}.js 
  fi
}

func_nodejs() {
  print_head "Configuring NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  print_head "Install NodeJS"
  yum install nodejs -y


  print_head "Add Application User"
   useradd ${app_user}

  print_head "Create Application Directory"
   rm -rf /app
   mkdir /app

   print_head "Download App Content"
   curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
   cd /app

   print_head "Unzip App Content"
   unzip /tmp/${component}.zip


   print_head "Install NodeJS Dependencies"
   npm install

   print_head "Create Application Directory"
   cp ${script_path}/${component}.service /etc/systemd/system/$component.service

   print_head "Start Cart Service"
   systemctl daemon-reload
   systemctl enable ${component}
   systemctl restart ${component}

   schema_setup

}

# func_java() {

# yum install maven -y

# useradd ${app_user}

# rm -rf /app
# mkdir /app

# curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 

# cd /app 
# unzip /tmp/shipping.zip

# cd /app 

# mvn clean package 
# mv target/shipping-1.0.jar shipping.jar 

# }


  # if [ "${schema_setup}" == "mysql" ]; then
  #   print_head "Install MySQL Client"
  #   yum install mysql -y

  # print_head "Install NodeJS"
  # yum install nodejs -y
  # print_head "Load Schema"
  #   mysql -h mysql-dev.devoash.tech -uroot -p${mysql_root_password} < /app/schema/shipping.sql
  # fi