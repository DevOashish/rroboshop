script=$(realpath "$0")
script_path=$(dirname $0)
source ${script_path}/common.sh

component = catalogue
func_nodejs

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> copy mongodbrepo <<<<<<<<<<<<<<<\e[0m"
cp ${script_path}/mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> Install mongodb <<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>> monogodb dns <<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.devoash.tech </app/schema/catalogue.js 