script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh


if [ -z "$mysql_root_password" ]; then
  echo Input MySQL Root Password Missing
  exit
fi

component=shipping
schema_setup=mysql
func_java()


