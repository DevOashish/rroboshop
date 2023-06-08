app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")

print_head() {
  echo -e "\e[35m>>>>>>>>> $1 <<<<<<<<\e[0m"
}

 func_status_check() {
   if [ $1 -eq 0 ]; then

  echo -e "\e[32msuccess\e[0m"
  else
   echo -e "\e[31msuccess\e[0m"
   exit 1
   fi


 }

 schema_setup() {

   if [ "$schema_setup" == "mongo" ]; then
    print_head "Copy MongoDB repo"
    cp ${script_path}/mongodb.repo /etc/yum.repos.d/mongodb.repo
    func_status_check $?



     print_head "Install MongoDB Client"
     yum install mongodb-org-shell -y
    func_status_check $?


     print_head "Load Schema"
     mongo --host mongodb-dev.devoash.tech </app/schema/${component}.js 
    func_status_check $?

  fi

  if [ "$schema_setup" == "mqsql" ]; then
 
     print_head "Install MySQL Client"
     yum install mysql -y
     func_status_check $?
       
    print_head "Load Schema"
    mysql -h mysql-dev.devoash.tech -uroot -p${mysql_root_password} < /app/schema/${component}.sql
    func_status_check $?
    
    fi

}

func_mscommonsteps() {

  print_head "Add user"
   useradd ${app_user}
  func_status_check $?


   print_head "remove and create app dir"
    rm -rf /app
    mkdir /app
    func_status_check $?

    print_head "Download app content"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
     func_status_check $?


     print_head "unzip app content"
     cd /app 
     unzip /tmp/${component}.zip
      func_status_check $?

}

func_systemd_service(){
  print_head "apth copy"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service
   func_status_check $?


 print_head "system start and reload ${component} services"

     systemctl daemon-reload
     systemctl enable ${component}
     systemctl restart ${component}
      func_status_check $?


}



func_nodejs() {
  print_head "Configuring NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash
   func_status_check $?


  print_head "Install NodeJS"
  yum install nodejs -y
   func_status_check $?


 
  func_mscommonsteps

   print_head "Install NodeJS Dependencies"
   npm install
    func_status_check $?



   func_systemd_service

   schema_setup

}

func_java() {


print_head "Install Maven"
yum install maven -y

 func_status_check $?


 
 
 func_mscommonsteps

  print_head "Install maven Dependencies"
  mvn clean package 

 func_status_check $?

mv target/${component}-1.0.jar ${component}.jar 


  schema_setup

  func_systemd_service
  
  }