script=$(realpath "$0")
script_path=$(dirname $0)
source ${script_path}/common.sh

component=cart
schema_setup=mongo
func_nodejs